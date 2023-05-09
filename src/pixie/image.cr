module Pixie
  class Image
    include Helpers

    # The location of the current working file
    getter path : String?

    @wand : LibMagick::MagickWand*

    ##
    # Creates a new `Image` with no data. This is the underlying method
    # used by all other constructors.
    #
    def initialize
      @wand = LibMagick.newMagickWand
    end

    ##
    # Creates a new `Image` from the given `LibMagick::MagickWand` instance.
    #
    def initialize(@wand : LibMagick::MagickWand*)
    end

    ##
    # Creates a new `Image` from the given `LibMagick::Image` instance.
    #
    def initialize(image : LibMagick::Image*)
      @wand = LibMagick.newMagickWandFromImage(image)
    end

    ##
    # Creates a new `Image` from the given stream. See `Image#read` for
    # more information.
    #
    def initialize(input : String | Bytes | IO)
      @wand = LibMagick.newMagickWand
      unless self.read(input)
        raise ReadError.new("Unable to read image from input")
      end
    end

    ##
    # Creates a new `Image` from the given Array, where each element is
    # a layer in the image.
    #
    def self.new(images : Array(String) | Array(Bytes) | Array(IO))
      img = Image.new
      images.each do |image|
        img.read(image)
      end
      img
    end

    ##
    # Creates a new `Image` from the given `Pixie::Image` instance.
    #
    def self.new(image : Image)
      new(image.to_unsafe_image)
    end

    ##
    # Creates a new blank image using the given width, height, and background
    # color. The default background color is transparent, and the format
    # is set to PNG.
    #
    # Example:
    # ```crystal
    # image = Image.new(640, 480, Pixel::RED)
    # ```
    #
    def self.new(width : Int, height : Int, background_color : Pixel = Pixel::TRANSPARENT)
      img = Image.new
      LibMagick.magickNewImage(img, width, height, background_color)
      # for some reason the above doesn't properly set the background color
      img.set_background_color(background_color)
      img
    end

    ##
    # Create an image from a map of pixels.
    #
    # Example:
    # ```crystal
    # image = Image.import_pixels(pixels, 0, 0, 16, "RGB")
    # ```
    #
    def self.import_pixels(pixels : Iterable(Int), width : Int, height : Int, depth : Int, map : String)
      image = Image.new(width, height)
      image.import_pixels(pixels, width, height, depth, map)
      image
    end

    ##
    # Get the individual image (layer) at the given index.
    #
    # Example:
    # ```crystal
    # image = Image.new("/path/to/image.gif")
    # image[0] # => Image
    # ```
    #
    def [](index : Int)
      raise IndexError.new if (index < 0) || (index > self.size + 1)
      old_pos = self.pos
      self.set_pos(index)
      image = Image.new(self.to_unsafe_image)
      self.set_pos(old_pos)
      image
    end

    ##
    # Get image details using special formatting characters.
    # See https://imagemagick.org/script/escape.php
    #
    # Example:
    # ```crystal
    # image = Image.new("/path/to/image.png")
    # image["%w"] # => "640"
    # image["%h"] # => "480"
    # image["%f"] # => "image.png"
    # ```
    #
    def [](format : String)
      image_info = LibMagick.cloneImageInfo(Pointer(LibMagick::ImageInfo).null)
      exception_info = LibMagick.acquireExceptionInfo

      raw = LibMagick.interpretImageProperties(image_info, self.to_unsafe_image, format, exception_info)
      Helpers.assert_no_exception(exception_info.value)

      LibMagick.destroyExceptionInfo(exception_info)
      LibMagick.destroyImageInfo(image_info)

      String.new(raw)
    end

    def ==(other : Image)
      self.signature == other.signature
    end

    ##
    # Returns an `Array(Image)`, where each image is a layer in the image. Useful for
    # `gif`, `pdf`, `psd`, and any other image format with layers.
    #
    # Example:
    # ```crystal
    # image = Image.new("/path/to/image.gif")
    # image.layers # => Array(Image)
    # ```
    #
    def layers
      images = [] of Image
      old_pos = self.pos
      self.rewind
      while self.has_next?
        images << Image.new(self.to_unsafe_image)
        self.set_pos(self.pos + 1)
      end
      self.set_pos(old_pos)
      images
    end

    ##
    # Returns true if there are multiple images in the image set, and
    # `pos` is less than the last image's index.
    #
    def has_next?
      LibMagick.magickHasNextImage(self)
    end

    ##
    # Returns the next image in the image set.
    #
    def next
      wand = LibMagick.magicNextImage(self)
      Image.new(wand)
    end

    ##
    # Returns true if there are multiple images in the image set, and
    # `pos` is greater than zero.
    #
    def has_prev?
      LibMagick.magickHasPreviousImage(self)
    end

    ##
    # Returns the previous image in the image set.
    #
    def prev
      wand = LibMagick.magickPreviousImage(self)
      Image.new(wand)
    end

    ##
    # Returns the current position in the image set. Will always be
    # zero for non-animated images.
    #
    def pos
      LibMagick.magickGetIteratorIndex(self).to_i
    end

    ##
    # Sets the current position in the image set. Will always be
    # zero for non-animated images.
    #
    def set_pos(index : Int)
      LibMagick.magickSetIteratorIndex(self, index)
    end

    ##
    # Reset the underlying iterator to the first image in the set.
    #
    def rewind
      LibMagick.magickResetIterator(self)
    end

    ##
    # Return the width of the image.
    #
    def width
      LibMagick.magickGetImageWidth(self).to_i
    end

    ##
    # Return the height of the image.
    #
    def height
      LibMagick.magickGetImageHeight(self).to_i
    end

    ##
    # Return exif data for the image as a `Hash(String, String)`.
    #
    def exif
      self["%[EXIF:*]"].strip.split("\n").map do |line|
        key, value = line.split("=", 2)
        key = key.sub("exif:", "")
        [key, value]
      end.to_h
    end

    ##
    # Returns true if the image has an alpha channel.
    #
    def has_alpha?
      LibMagick.magickGetImageAlphaChannel(self)
    end

    ##
    # Set the image's alpha channel to the given `LibMagick::AlphaChannelOption`.
    # Valid options are:
    # - `:undefined`
    # - `:activate`
    # - `:associate`
    # - `:background`
    # - `:copy`
    # - `:deactivate`
    # - `:discrete`
    # - `:disassociate`
    # - `:extract`
    # - `:off`
    # - `:on`
    # - `:opaque`
    # - `:remove`
    # - `:set`
    # - `:shape`
    # - `:transparent`
    #
    def set_alpha(value : LibMagick::AlphaChannelOption)
      LibMagick.magickSetImageAlphaChannel(self, value)
    end

    ##
    # Return the background color of the image as a `Pixie::Pixel`.
    #
    def background_color
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageBackgroundColor(self, pw)
      Pixel.new(pw)
    end

    ##
    # Set the background color of the image to the given `Pixie::Pixel`.
    #
    def set_background_color(background : Pixel)
      LibMagick.magickSetImageBackgroundColor(self, background)
    end

    ##
    # Get the image as a `Bytes` instance.
    #
    def blob
      size = self.bytesize.to_u64
      data = LibMagick.magickGetImageBlob(self, pointerof(size))
      Bytes.new(data, size)
    end

    ##
    # Returns the chromaticity blue primary point for the image as
    # an x, y, z tuple.
    #
    def blue_primary
      LibMagick.magickGetImageBluePrimary(self, out x, out y, out z)
      {x, y, z}
    end

    ##
    # Set the chromaticity blue primary point for the image to the
    # given x, y, and z values.
    #
    def set_blue_primary(x, y, z)
      LibMagick.magickSetImageBluePrimary(self, x, y, z)
    end

    ##
    # Returns the chromaticity green primary point for the image as
    # an x, y, z tuple.
    #
    def green_primary
      LibMagick.magickGetImageGreenPrimary(self, out x, out y, out z)
      {x, y, z}
    end

    ##
    # Set the chromaticity green primary point for the image to the
    # given x, y, and z values.
    #
    def set_green_primary(x, y, z)
      LibMagick.magickSetImageGreenPrimary(self, x, y, z)
    end

    ##
    # Returns the chromaticity red primary point for the image as
    # an x, y, z tuple.
    #
    def red_primary
      LibMagick.magickGetImageRedPrimary(self, out x, out y, out z)
      {x, y, z}
    end

    ##
    # Set the chromaticity red primary point for the image to the
    # given x, y, and z values.
    #
    def set_red_primary(x, y, z)
      LibMagick.magickSetImageRedPrimary(self, x, y, z)
    end

    ##
    # Return the border color of the image as a `Pixie::Pixel`.
    #
    def border_color
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageBorderColor(self, pw)
      Pixel.new(pw)
    end

    ##
    # Set the border color of the image to the given `Pixie::Pixel`.
    #
    # Example:
    # ```crystal
    # image = Image.new("/path/to/image.png")
    # image.border_color = Pixel::RED
    # ```
    #
    def set_border_color(color : Pixel)
      LibMagick.magickSetImageBorderColor(self, color)
    end

    ##
    # Apply an adaptive blur to the image.
    #
    def adaptive_blur(radius : Float, sigma : Float)
      LibMagick.magickAdaptiveBlurImage(self, radius, sigma)
    end

    ##
    # Apply an adaptive resize to the image.
    #
    def adaptive_resize(width : Int, height : Int, preserve_aspect_ratio : Bool = false)
      width, height = self.preserve_aspect_ratio(self.width, self.height, width, height) if preserve_aspect_ratio
      LibMagick.magickAdaptiveResizeImage(self, width, height)
    end

    ##
    # Apply an adaptive sharpen to the image.
    #
    def adaptive_sharpen(radius : Float, sigma : Float)
      LibMagick.magickAdaptiveSharpenImage(self, radius, sigma)
    end

    ##
    # Apply an adaptive threshold to the image.
    #
    def adaptive_threshold(width : Int, height : Int, bias : Float)
      LibMagick.magickAdaptiveThresholdImage(self, width, height, bias)
    end

    ##
    # Add an image to the image set.
    #
    def add_image(image : Image)
      LibMagick.magickAddImage(self, image)
    end

    ##
    # Add noise to the image. Valid noise types are:
    # - `:undefined`
    # - `:uniform`
    # - `:gaussian`
    # - `:multiplicative_gaussian`
    # - `:impulse`
    # - `:laplacian`
    # - `:poisson`
    # - `:random`
    #
    def add_noise(noise_type : LibMagick::NoiseType, attenuate : Float = 1.0)
      LibMagick.magickAddNoiseImage(self, noise_type, attenuate)
    end

    def affine_transform(brush : Brush)
      LibMagick.magickAffineTransformImage(self, Brush)
    end

    def annotate(brush : Brush, x : Float, y : Float, angle : Float, text : String)
      LibMagick.magickAnnotateImage(self, Brush, x, y, text)
    end

    ##
    # Animate the image sequence using the given server name.
    #
    def animate(server_name : String = ":0")
      LibMagick.magickAnimateImages(self, server_name)
    end

    ##
    # Append all images together into a single image.
    #
    def append(top_to_bottom : Bool = false)
      wand = LibMagick.magickAppendImages(self, top_to_bottom)
      Image.new(wand)
    end

    ##
    # Automatically adjust the gamma level of this image.
    #
    def auto_gamma
      LibMagick.magickAutoGammaImage(self)
    end

    ##
    # Automatically adjust the level of this image.
    #
    def auto_level
      LibMagick.magickAutoLevelImage(self)
    end

    ##
    # Automatically orient the image based on its EXIF data.
    #
    def auto_orient
      LibMagick.magickAutoOrientImage(self)
    end

    ##
    # Automatically threshold the image using the given method.
    # Valid methods are:
    # - `:undefined`
    # - `:kapur`
    # - `:ohtsu`
    # - `:triangle`
    #
    def auto_threshold(method : LibMagick::AutoThresholdMethod)
      LibMagick.magickAutoThresholdImage(self, method)
    end

    ##
    # Set the black threshold of the image.
    #
    def black_threshold(threshold : Pixel)
      LibMagick.magickBlackThresholdImage(self, threshold)
    end

    ##
    # Set the blue shift factor of the image.
    #
    def blue_shift(factor : Float)
      LibMagick.magickBlueShiftImage(self, factor)
    end

    ##
    # Blur the image using the given radius and sigma.
    #
    def blur(radius : Float, sigma : Float)
      LibMagick.magickBlurImage(self, radius, sigma)
    end

    ##
    # Add a border to the image using the given `Pixie::Pixel`.
    def border(border_color : Pixel, width : Int, height : Int, compose : LibMagick::CompositeOperator = :undefined)
      LibMagick.magickBorderImage(self, border_color, width, height, compose)
    end

    ##
    # Apply a brightness and contrast adjustment to the image.
    def brightness_contrast(brightness : Float, contrast : Float)
      LibMagick.magickBrightnessContrastImage(self, brightness, contrast)
    end

    ##
    # Detect edges in the image using the given radius.
    #
    def canny_edge(radius : Float, sigma : Float, lower_percent : Float, upper_percent : Float)
      LibMagick.magickCannyEdgeImage(self, radius, sigma, lower_percent, upper_percent)
    end

    ##
    # Applies a channel expression to the specified image.
    #
    def channel_fx(expression : String)
      LibMagick.magickChannelFxImage(self, expression)
    end

    ##
    # Apply a charcoal effect to the image using the given radius and sigma.
    #
    def charcoal(radius : Float, sigma : Float)
      LibMagick.magickCharcoalImage(self, radius, sigma)
    end

    ##
    # Removes a region of a canvas and collapses the canvas to occupy the removed portion.
    #
    def chop(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickChopImage(self, width, height, x, y)
    end

    ##
    # a variant of adaptive histogram equalization in which the contrast amplification
    # is limited, so as to reduce this problem standard non-contrast
    # limited AHE.
    #
    def clahe(width : Int, height : Int, number_bins : Float, clip_limit : Float)
      LibMagick.magickCLAHEImage(self, width, height, number_bins, clip_limit)
    end

    ##
    # Restricts the color range from 0 to the quantum depth.
    #
    def clamp
      LibMagick.magickClampImage(self)
    end

    ##
    # Clips along the first path from the 8BIM profile, if present.
    #
    def clip
      LibMagick.magickClipImage(self)
    end

    ##
    # Clips along the named paths from the 8BIM profile, if present.
    # Later operations take effect inside the path. Id may be a number if
    # preceded with #, to work on a numbered path, e.g., "#1" to use the first
    # path.
    #
    def clip_path(pathname : String, inside : Bool = false)
      LibMagick.magickClipImagePath(self, pathname, inside)
    end

    ##
    # Replaces colors in the image from a color lookup table.
    #
    def clut(clut : Image, method : LibMagick::PixelInterpolateMethod)
      LibMagick.magickClutImage(self, clut, method)
    end

    ##
    # Composites a set of images while respecting any page offsets and disposal methods.
    # GIF, MIFF, and MNG animation sequences typically start with an image background
    # and each subsequent image varies in size and offset. Returns a new sequence where
    # each image in the sequence is the same size as the first and composited
    # with the next image in the sequence.
    #
    def coalesce
      LibMagick.magickCoalesceImages(self)
    end

    ##
    # accepts a lightweight Color Correction Collection (CCC) file which solely
    # contains one or more color corrections and applies the color correction to
    # the image. Here is a sample CCC file:
    # ```xml
    #   <ColorCorrectionCollection xmlns="urn:ASC:CDL:v1.2">
    #     <ColorCorrection id="cc03345">
    #       <SOPNode>
    #         <Slope> 0.9 1.2 0.5 </Slope>
    #         <Offset> 0.4 -0.5 0.6 </Offset>
    #         <Power> 1.0 0.8 1.5 </Power>
    #       </SOPNode>
    #       <SATNode>
    #         <Saturation> 0.85 </Saturation>
    #       </SATNode>
    #     </ColorCorrection>
    #   </ColorCorrectionCollection>
    # ```
    # which includes the offset, slope, and power for each of the RGB channels
    # as well as the saturation.
    #
    def color_correct(collection : String)
      LibMagick.magickColorDecisionListImage(self, collection)
    end

    ##
    # Blends the fill color with each pixel in the image.
    #
    def colorize(colorize : Pixel, blend : Pixel)
      LibMagick.magickColorizeImage(self, coloize, blend)
    end

    ##
    # Apply color transformation to an image. The method permits saturation
    # changes, hue rotation, luminance to alpha, and various other effects.
    # Although variable-sized transformation matrices can be used, typically
    # one uses a 5x5 matrix for an RGBA image and a 6x6 for CMYKA (or RGBA with
    # offsets). The matrix is similar to those used by Adobe Flash except
    # offsets are in column 6 rather than 5 (in support of CMYKA images) and
    # offsets are normalized (divide Flash offset by 255).
    #
    def color_matrix(matrix : LibMagick::KernelInfo)
      LibMagick.magickColorMatrixImage(sel, matrix)
    end

    ##
    # Combines one or more images into a single image. The grayscale value
    # of the pixels of each image in the sequence is assigned in order to
    # the specified channels of the combined image. The typical ordering
    # would be image 1 => Red, 2 => Green, 3 => Blue, etc.
    #
    def combine(colorspace : LibMagick::ColorspaceType)
      LibMagick.magickCombineImages(self, colorspace)
    end

    ##
    # Adds a comment to your image.
    #
    def comment(comment : String)
      LibMagick.magickCommentImage(self, comment)
    end

    ##
    # Compares each image with the next in a sequence and returns the maximum
    # bounding region of any pixel differences it discovers.
    #
    def compare_layers(method : LibMagick::LayerMethod)
      wand = LibMagick.magickCompareImagesLayers(self, method)
      new(wand)
    end

    ##
    # Compares an image to a reconstructed image and returns the specified
    # difference image.
    #
    def compare(reference : Image, metric : LibMagick::MetricType, distortion : Float)
      LibMagick.magickCompareImages(self, reference, metric, distortion)
    end

    ##
    # Performs complex mathematics on an image sequence using the given
    # oprtator. Valid operators are:
    # - `:undefined`
    # - `:add`
    # - `:conjugate`
    # - `:divide`
    # - `:magnitude_phase`
    # - `:multiply`
    # - `:real_imaginary`
    # - `:subtract`
    #
    def complex(op : LibMagick::ComplexOperator)
      LibMagick.magickComplexImages(self, op)
    end

    ##
    # Composites two images together using the given operator.
    # See `Image#complex` for a list of valid operators.
    #
    def composite(source : Image, operator : LibMagick::CompositeOperator, clip_to_self : Bool, x : Int, y : Int)
      LibMagick.magickCompositeImage(self, source, operator, clip_to_self, x, y)
    end

    ##
    # Composites two images together using the given operator and gravity.
    # See `Image#complex` for a list of valid operators. Valid
    # gravities are:
    # - `:undefined`
    # - `:forget`
    # - `:north_west`
    # - `:north`
    # - `:north_east`
    # - `:west`
    # - `:center`
    # - `:east`
    # - `:south_west`
    # - `:south`
    # - `:south_east`
    # - `:static`
    #
    def composite(source : Image, compose : LibMagick::CompositeOperator, gravity : LibMagick::GravityType)
      LibMagick.magickCompositeImageGravity(self, source, compose, gravity)
    end

    ##
    # Composite the images in the source wand over
    # the images in the destination wand in sequence, starting with the
    # current image in both lists. Each layer from the two image lists are
    # composted together until the end of one of the image lists is reached.
    # The offset of each composition is also adjusted to match the virtual
    # canvas offsets of each layer. As such the given offset is relative to
    # the virtual canvas, and not the actual image. Composition uses given
    # x and y offsets, as the 'origin' location of the source images virtual
    # canvas (not the real image) allowing you to compose a list of 'layer
    # images' into the destination images. This makes it well suitable for
    # directly composing 'Clears Frame Animations' or 'Coalesced Animations'
    # onto a static or other 'Coalesced Animation' destination image list.
    # GIF disposal handling is not looked at.
    #
    # Special case:- If one of the image sequences is the last image (just a
    # single image remaining), that image is repeatedly composed with all the
    # images in the other image list. Either the source or destination lists
    # may be the single image, for this situation. In the case of a single
    # destination image (or last image given), that image will be cloned to
    # match the number of images remaining in the source image list. This is
    # equivalent to the "-layer Composite" Shell API operator.
    #
    # For a list of valid operators, see `Image#complex`.
    #
    def composite_layers(source : Image, compose : LibMagick::CompositeOperator, x : Int, y : Int)
      LibMagick.magickCompositeLayers(self, source, compose, x, y)
    end

    ##
    # Returns the connected-components of the image uniquely labeled. The returned
    # connected components image colors member defines the number of
    # unique objects. Choose from 4 or 8-way connectivity.
    #
    def connected_components(connectivity : Int)
      raise "Connectivity must be 4 or 8" unless [4, 8].includes?(connectivity)
      LibMagick.magickConnectedComponentsImage(self, connectivity, out objects)
      Array(LibMagick::CCObjectInfo).new(connectivity) do |i|
        objects[i]
      end
    end

    ##
    # Enhances the intensity differences between the lighter and darker elements of the image.
    # Set sharpen to a value other than 0 to increase the image contrast otherwise the
    # contrast is reduced.
    #
    def contrast(sharpen : Bool)
      LibMagick.magickContrastImage(self, sharpen)
    end

    ##
    # Enhances the contrast of a color image by adjusting the pixels color to span the entire
    # range of colors available. You can also reduce the influence of a particular channel
    # with a gamma value of 0.
    def contrast_stretch(black_point : Float, white_point : Float)
      LibMagick.magickContrastStretchImage(self, black_point, white_point)
    end

    ##
    # Applies a custom convolution kernel to the image.
    #
    def convolve(kernel : LibMagick::KernelInfo)
      LibMagick.magickConvolveImage(self, kernel)
    end

    ##
    # Extracts a region of the image.
    #
    def crop(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickCropImage(self, width, height, x, y)
    end

    ##
    # Displaces an image's colormap by a given number of positions. If you cycle the
    # colormap a number of times you can produce a psychodelic effect.
    #
    def cycle_colormap(displace : Int)
      LibMagick.magickCycleColormapImage(self, displace)
    end

    ##
    # Adds an image to the wand comprised of the pixel data you supply. The pixel data must
    # be in scanline order top-to-bottom. The data can be char, short int,
    # int, float, or double. Float and double require the pixels to
    # be normalized [0..1], otherwise [0..Max], where Max is the
    # maximum value the type can accomodate (e.g. 255 for char).
    #
    # For example, to create a 640x480 image from unsigned red-green-blue character data:
    # ```crystal
    # image = Image.new
    # data = Array(UInt8).new(640 * 480 * 3) { 0u8 }
    # image.constitute(640, 480, "RGB", :char, data)
    # ```
    #
    def constitute(columns : Int, rows : Int, map : String, storage : LibMagick::StorageType, pixels : Array(U)) forall U
      LibMagick.magickConstituteImage(self, columns, rows, map, storage, pixels)
    end

    ##
    # Converts cipher pixels to plain pixels.
    #
    def decipher(passphrase : String)
      LibMagick.magickDecipherImage(self, passphrase)
    end

    ##
    # Compares each image with the next in a sequence and returns the maximum bounding
    # region of any pixel differences it discovers.
    #
    def deconstruct
      wand = LibMagick.magickDeconstructImages(self)
      new(wand)
    end

    ##
    # Removes skew from the image. Skew is an artifact that occurs in scanned images
    # because of the camera being misaligned, imperfections in the scanning or surface,
    # or simply because the paper was not placed completely flat when scanned.
    #
    def deskew(threshold : Float)
      LibMagick.magickDeskewImage(self, threshold)
    end

    ##
    # Reduces the speckle noise in an image while perserving the edges of the original image.
    #
    def despeckle
      LibMagick.magickDespeckleImage(self)
    end

    ##
    # Displays an image using the given X server.
    #
    def display(x_server : String = ":0")
      LibMagick.magickDisplayImage(self, x_server)
    end

    ##
    # Displays an image sequence using the given X server.
    #
    def displays(x_server : String = ":0")
      LibMagick.magickDisplayImages(self, x_server)
    end

    ##
    # Distorts an image using various distortion methods, by mapping color lookups of the
    # source image to a new destination image usally of the same size as the source
    # image, unless `best_fit` is set to true.
    #
    # Valid distortion methods are:
    # - `:undefined`
    # - `:affine`
    # - `:affine_projection`
    # - `:scale_rotate_translate`
    # - `:perspective`
    # - `:perspective_projection`
    # - `:bilinear_forward`
    # - `:bilinear_reverse`
    # - `:polynomial`
    # - `:arc`
    # - `:polar`
    # - `:de_polar`
    # - `:cylinder2plane`
    # - `:plane2cylinder`
    # - `:barrel`
    # - `:barrel_inverse`
    # - `:shepards`
    # - `:resize`
    # - `:sentinel`
    #
    # Example:
    # ```crystal
    # image = Image.new("/path/to/image.png")
    # image.distort(:affine, [0.0, 0.0, 0.0, 0.0, 0.0, 0.0])
    # ```
    def distort(method : LibMagick::DistortMethod, args : Array(Float64), best_fit : Bool = false)
      LibMagick.magickDistortImage(self, method, args.size, args, best_fit)
    end

    def draw(brush : Brush)
      LibMagick.magickDrawImage(self, brush)
    end

    def draw(&block : Brush ->)
      brush = Brush.new
      yield brush
      draw(brush)
    end

    ##
    # Enhances edges within the image with a convolution filter of the given radius.
    # Using a radius of 0 will select a suitable radius for you.
    def edge(radius : Float = 0.0)
      LibMagick.magickEdgeImage(self, radius)
    end

    ##
    # Enhance edges within the image with a convolution filter of the given radius and sigma.
    # Using a radius of 0 will select a suitable radius for you.
    def emboss(radius : Float = 0.0, sigma : Float = 0.0)
      LibMagick.magickEmbossImage(self, radius, sigma)
    end

    def encipher(passphrase : String)
      LibMagick.magickEncipherImage(self, passphrase)
    end

    def enhance
      LibMagick.magickEnhanceImage(self)
    end

    def equalize
      LibMagick.magickEqualizeImage(self)
    end

    def evaluate(operator : LibMagick::MagickEvaluateOperator, value : Float)
      wand = LibMagick.magickEvaluateImage(self, operator, value)
      Image.new(wand)
    end

    def evaluate(operator : LibMagick::MagickEvaluateOperator)
      wand = LibMagick.magickEvaluateImages(self, operator)
      Image.new(wand)
    end

    ##
    # Extract pixel data from the image and return it as a multi-dimensional array of rows and columns, each
    # containing an array of pixel data represnting the given map (defaulting to RGB). The map can be
    # any combination or order of:
    # - R = red
    # - G = green
    # - B = blue
    # - A = alpha (0 is transparent)
    # - O = opacity (0 is opaque)
    # - C = cyan
    # - Y = yellow
    # - M = magenta
    # - K = black
    # - I = intensity (for grayscale)
    # - P = pad
    #
    # Example:
    # ```crystal
    # image = Image.new("/path/to/image.png")
    # image.pixels.each do |row|
    #   row.each do |col|
    #     puts col # => [255, 255, 255]
    #   end
    # end
    # ```
    #
    def pixels(x : Int = 0, y : Int = 0, columns : Int = width, rows : Int = height, map : String = "RGB", storage : LibMagick::StorageType = :char)
      arr = Array(UInt8).new(columns * rows * map.size) { 0u8 }
      LibMagick.magickExportImagePixels(self, x, y, columns, rows, map, storage, arr)
      Array(Array(Array(UInt8))).new(rows) do |row|
        Array(Array(UInt8)).new(columns) do |col|
          Array(UInt8).new(map.size) do |i|
            arr[(row * columns + col) * map.size + i]
          end
        end
      end
    end

    ##
    # Extend the image as defined by the geometry, gravity, and wand background color. Set the
    # (x,y) offset of the geometry to move the original wand relative to the extended wand.
    #
    def extend(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickExtentImage(self, width, height, x, y)
    end

    def flip
      LibMagick.magickFlipImage(self)
    end

    def flood_fill_paint(fill : Pixel, fuzz : Float, border_color : Pixel, x : Int, y : Int, invert : Bool = false)
      LibMagick.magickFloodfillPaintImage(self, fill, fuzz, border_color, x, y, invert)
    end

    def flop
      LibMagick.magickFlopImage(self)
    end

    def forward_fourier_transform(magnitude : Float)
      LibMagick.magickForwardFourierTransformImage(self, magnitude)
    end

    def frame(matte_color : Pixel, width : Int, height : Int, inner_bevel : Int, outer_bevel : Int, compose : LibMagick::CompositeOperator)
      LibMagick.magickFrameImage(self, matte_color, width, height, inner_bevel, outer_bevel, operator)
    end

    def function(function : LibMagick::MagickFunction, args : Array(Float64))
      LibMagick.magickFunctionImage(self, function, args.size, args.to_unsafe)
    end

    def fx(expression : String)
      LibMagick.magickFxImage(self, expression)
    end

    def gamma(gamma : Float)
      LibMagick.magickGammaImage(self, gamma)
    end

    def gaussian_blur(radius : Float, sigma : Float)
      LibMagick.magickGaussianBlurImage(self, radius, sigma)
    end

    def features(distance)
      LibMagick.magickGetImageFeatures(self, distance).try &.value
    end

    # TODO: Figure out how to specify a channel
    def kurtosis
      LibMagick.magickGetImageKurtosis(self, out kurtosis, out skewness)
      { kurtosis: kurtosis, skewness: skewness }
    end

    def mean
      LibMagick.magickGetImageMean(self, out mean, out standard_deviation)
      { mean: mean, standard_deviation: standard_deviation }
    end

    def range
      LibMagick.magickGetImageRange(self, out minima, out maxima)
      { minima: minima, maxima: maxima }
    end

    def statistics(channel : LibMagick::ChannelType)
      stats = LibMagick.magickGetImageStatistics(self)
      (stats + channel.value).value
    end

    def set_color(color : Pixel)
      LibMagick.magickSetImageColor(self, color)
    end

    def colormap_color(index)
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageColormapColor(self, index, pw)
      pw.value
    end

    def set_colormap_color(index : Int, color : Pixel)
      LibMagick.magickSetImageColormapColor(self, index, color)
    end

    def colors
      LibMagick.magickGetImageColors(self).to_i
    end

    def colorspace
      LibMagick.magickGetImageColorspace(self)
    end

    def set_colorspace(colorspace : LibMagick::ColorspaceType)
      LibMagick.magickSetImageColorspace(self colorspace)
    end

    def composite_operator
      LibMagick.magickGetImageCompose(self)
    end

    def set_composite_operator(op : LibMagick::CompositeOperator)
      LibMagick.magickSetImageCompose(self, op)
    end

    def compression
      LibMagick.magickGetImageCompression(self)
    end

    def set_compression(value : LibMagick::CompressionType)
      LibMagick.magickSetImageCompression(self, value)
    end

    def compression_quality
      LibMagick.magickGetImageCompressionQuality(self).to_i
    end

    def set_compression_quality(quality : Int)
      LibMagick.magickSetImageCompressionQuality(self, quality)
    end

    def delay
      LibMagick.magickGetImageDelay(self).to_i
    end

    def set_delay(val : Int)
      LibMagick.magickSetImageDelay(self, val)
    end

    def depth
      LibMagick.magickGetImageDepth(self).to_i
    end

    def set_depth(val : Int)
      LibMagick.magickSetImageDepth(self, val)
    end

    def dispose
      LibMagick.magickGetImageDispose
    end

    def set_dispose(val : LibMagick::DisposeType)
      LibMagick.magickSetImageDispose(self, val)
    end

    def distortion(reference : Wand, metric : LibMagick::MetricType)
      LibMagick.magickGetImageDistortion(self, reference, metric, out distortion)
      distortion.to_i
    end

    def distortions(reference : Wand, metric : LibMagick::MetricType, channel : LibMagick::ChannelType)
      distortions = LibMagick.magickGetImageDistortions(self, reference, metric)
      (distortions + channel.value).value
    end

    def endian
      LibMagick.magickGetImageEndian(self)
    end

    def set_endian(val : LibMagick::EndianType)
      LibMagick.magickSetImageEndian(self, val)
    end

    def set_extent(width : Int, height : Int)
      LibMagick.magickSetImageExtent(self, width, height)
    end

    def filename
      String.new(LibMagick.magickGetFilename(self))
    end

    def set_filename(name : String)
      LibMagick.magickSetFilename(self, name)
    end

    def filename
      String.new(LibMagick.magickGetImageFilename(self))
    end

    def set_filename(val : String)
      LibMagick.magickSetImageFilename(self, val)
    end

    def format
      String.new(LibMagick.magickGetImageFormat(self))
    end

    def set_format(val : String)
      LibMagick.magickSetImageFormat(self, val)
    end

    def fuzz
      LibMagick.magickGetImageFuzz(self)
    end

    def set_fuzz(val : Float64)
      LibMagick.magickSetImageFuzz(self, val)
    end

    def gamma
      LibMagick.magickGetImageGamma(self)
    end

    def set_gamma(val : Float64)
      LibMagick.magickSetImageGamma(self, val)
    end

    def gravity
      LibMagick.magickGetImageGravity(self)
    end

    def set_gravity(val : Float64)
      LibMagick.magickSetImageGravity(self, val)
    end

    def histogram(n_colors = nil)
      n_colors ||= n_unique_colors
      colors = n_colors.to_i
      wands = LibMagick.magickGetImageHistogram(self, pointerof(colors))
      Array(Pixel).new(n_colors) do |i|
        (wands + i).value.value
      end
    end

    def interlace_scheme
      LibMagick.magickGetImageInterlaceScheme(self)
    end

    def set_interlace_scheme(val : LibMagick::InterlaceType)
      LibMagick.magickSetImageInterlaceScheme(self, val)
    end

    def pixel_interpolation_method
      LibMagick.magickGetImageInterpolateMethod(self)
    end

    def set_pixel_interpolation_method(val : LibMagick::PixelInterpolateMethod)
      LibMagick.magickSetImagePixelInterpolateMethod(self, val)
    end

    def iterations
      LibMagick.magickGetImageIterations(self).to_i
    end

    def set_iterations(val : Int)
      LibMagick.magickSetImageIterations(self, val)
    end

    def bytesize
      LibMagick.magickGetImageLength(self, out size)
      size.to_i
    end

    def set_matte(val : Bool)
      LibMagick.magickSetImageMatte(self, val)
    end

    def matte_color
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageMatteColor(self, pw)
      pw.value
    end

    def set_matte_color(val : Pixel)
      LibMagick.magickSetImageMatteColor(self, val)
    end

    def orientation
      LibMagick.magickGetImageOrientation(self)
    end

    def set_orientation(val : LibMagick::OrienationType)
      LibMagick.magickSetImageOrientation(self, val)
    end

    def page
      LibMagick.magickGetImagePage(self, out width, out height, out x, out y)
      {width: width, height: height, x: x, y: y}
    end

    def set_page(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickSetImagePage(self, width, height, x, y)
    end

    ##
    # Get the pixel at the given x and y coordinates.
    #
    def pixel(x, y)
      pixel = Pixel.new
      LibMagick.magickGetImagePixelColor(self, x, y, pixel)
      pixel
    end

    ##
    # Set the pixel at the given x and y coordinates.
    #
    def set_pixel(x : Int, y : Int, color : Pixel)
      LibMagick.magickSetImagePixelColor(self, x, y, color)
    end

    def get_region(width, height, x, y)
      wand = LibMagick.magickGetImageRegion(self, width, height, x, y)
      new(wand)
    end

    def intent
      LibMagick.magickGetImageRenderingIntent(self)
    end

    def set_intent(val : LibMagick::RenderingIntent)
      LibMagick.magickSetImageRenderingIntent(self, val)
    end

    def resolution
      LibMagick.magickGetImageResolution(self, out x, out y)
      {x, y}
    end

    def set_resolution(x : Float64, y : Float64)
      LibMagick.magickSetImageResolution(self, x, y)
    end

    def scene
      LibMagick.magickGetImageScene(self).to_i
    end

    def set_scen(scene : Int)
      LibMagick.magickSetImageScene(self, scene)
    end

    def signature
      String.new(LibMagick.magickGetImageSignature(self))
    end

    def ticks_per_second
      LibMagick.magickGetImageTicksPerSecond(self).to_i
    end

    def set_ticks_per_second(val : Int)
      LibMagick.magickSetImageTicksPerSecond(self, val)
    end

    def type
      LibMagick.magickGetImageType(self)
    end

    def set_type(val : LibMagick::ImageType)
      LibMagick.magickSetImageType(self, val)
    end

    def units
      LibMagick.magickGetImageUnits(self)
    end

    def set_units(val : LibMagick::ResolutionType)
      LibMagick.magickSetImageUnits(self, val)
    end

    def virtual_pixel_method
      LibMagick.magickGetImageVirtualPixelMethod(self)
    end

    def set_virtual_pixel_method(val : LibMagick::VirtualPixelMethod)
      LibMagick.magickSetImageVirtualPixelMethod(self, val)
    end

    def white_point
      LibMagick.magickGetImageWhitePoint(self, out x, out y, out z)
      {x: x, y: y, z: z}
    end

    def set_white_point(x : Float64, y : Float64, z : Float64)
      LibMagick.magickSetImageWhitePoint(self, x, y, z)
    end

    def total_ink_density
      LibMagick.magickGetImageTotalInkDensity(self)
    end

    # TODO
    # def hald_clut(hald_coder : HaldCoder)
    #   LibMagick.magickHaldClutImage(self, hald_coder)
    # end

    def hough_line(width, height, threshold)
      LibMagick.magickHoughLineImage(self, width, height, threshold)
    end

    def identify
      String.new(LibMagick.magickIdentifyImage(self))
    end

    def identify_type
      LibMagick.magickIdentifyImageType(self)
    end

    def set_artifact(key : String, value : String)
      LibMagick.magickSetImageArtifact(self, key, value)
    end

    def implode(radius, method : PixelInterpolateMethod = :average)
      LibMagick.magickImplodeImage(self, radius, method)
    end

    def import_pixels(pixels : Iterable(Int), width, height, depth : Int, map : String = "RGB")
      storage_type = depth_to_storage_type(depth)
      unsafe = pixels.to_unsafe
      LibMagick.magickImportImagePixels(self, 0, 0, width, height, map, storage_type, unsafe)
      check_exception!
    end

    def interpolative_resize(width, height, method : LibMagick::PixelInterpolateMethod = :average, preserve_aspect_ratio : Bool = false)
      width, height = self.preserve_aspect_ratio(self.width, self.height, width, height) if preserve_aspect_ratio
      LibMagick.magickInterpolativeResizeImage(self, width, height, method)
    end

    def inverse_fourier_transform(phase_image : Pixie::Wand, magnitude = false)
      LibMagick.magickInverseFourierTransformImage(self, phase_image, magnitude)
    end

    def kuwahara_filter(radius : Float64, sigma : Float64)
      LibMagick.magickKuwaharaImage(self, radius, sigma)
    end

    def label(label : String)
      LibMagick.magickLabelImage(self, label)
    end

    def level(black_point : Float64, gamma : Float64, white_point : Float64)
      LibMagick.magickLevelImage(self, black_point, gamma, white_point)
    end

    def level_colors(black_color : Pixel, white_color : Pixel, invert = false)
      LibMagick.magickLevelImageColors(self, black_color, white_color, invert)
    end

    def levelize(black_point : Float64, white_point : Float64, gamma : Float64)
      LibMagick.magickLevelizeImage(self, black_point, white_point, gamma)
    end

    def linear_stretch(black_point : Float64, white_point : Float64)
      LibMagick.magickLinearStretchImage(self, black_point, white_point)
    end

    def liquid_rescale(width : Int, height : Int, delta_x : Float64 = 0.0, rigidity : Float64 = 0.0)
      LibMagick.magickLiquidRescaleImage(self, width, height, delta_x, rigidity)
    end

    def enhance_local_contrast(radius : Float64, strength : Float64)
      LibMagick.magickLocalContrastImage(self, radius, strength)
    end

    def magnify
      LibMagick.magickMagnifyImage(self)
    end

    def mean_shift(width : Int, height : Int, color_distance : Float64)
      LibMagick.magickMeanShiftImage(self, width, height, color_distance)
    end

    def merge_layers(method : LibMagick::LayerMethod = :merge)
      LibMagick.magickMergeImageLayers(self, method)
    end

    def minify
      LibMagick.magickMinifyImage(self)
    end

    def modulate(brightness : Float64, saturation : Float64, hue : Float64)
      LibMagick.magickModulateImage(self, brightness, saturation, hue)
    end

    ##
    # Create a montage from the images in the current set.
    #
    def montage(thumbnail_geometry : String? = nil, tile_geometry : String? = nil, brush : Brush = Brush.new, mode : LibMagick::MontageMode = :undefined, frame : String? = nil)
      old_pos = self.pos
      self.rewind

      if !tile_geometry
        # Create a default geometry based on the nmber of images in the wand.
        n = self.size
        cols = Math.sqrt(n).ceil
        rows = (n / cols.to_f).ceil
        tile_geometry = "#{cols}x#{rows}+0+0"
      end

      if !thumbnail_geometry
        # Create a default geometry based on the nmber of images in the wand.
        n = self.size
        width = self.width
        height = self.height
        cols = Math.sqrt(n).ceil
        rows = (n / cols.to_f).ceil
        tile_width = (width / cols.to_f).ceil
        tile_height = (height / rows.to_f).ceil
        thumbnail_geometry = "#{tile_width}x#{tile_height}+0+0"
      end

      frame ||= "0x0+0+0"

      wand = LibMagick.magickMontageImage(self, brush, tile_geometry, thumbnail_geometry, mode, frame)

      self.set_pos(old_pos)
      Image.new(wand)
    end

    def morphology(n_frames : Int)
      wand = LibMagick.magickMorphImages(self, n_frames)
      Image.new(wand)
    end

    def morphology_method(method : LibMagick::MorphologyMethod, iterations : Int, kernel : LibMagick::KernelInfo*)
      LibMagick.magickMorphologyImage(self, method, iterations, kernel)
    end

    def motion_blur(radius : Float64, sigma : Float64, angle : Float64)
      LibMagick.magickMotionBlurImage(self, radius, sigma, angle)
    end

    def negate(gray : Bool)
      LibMagick.magickNegateImage(self, gray)
    end

    def normalize
      LibMagick.magickNormalizeImage(self)
    end

    def oil_paint(radius : Float64, sigma : Float64)
      LibMagick.magickOilPaintImage(self, radius, sigma)
    end

    def opaque_paint(target_color : Pixel, fill_color : Pixel, fuzz : Float64, invert : Bool = false)
      LibMagick.magickOpaquePaintImage(self, target_color, fill_color, fuzz, invert)
    end

    def optimize_layers
      LibMagick.magickOptimizeImageLayers(self)
    end

    def optimize_transparency
      LibMagick.magickOptimizeImageTransparency(self)
    end

    def ordered_dither(threshold_map : String)
      LibMagick.magickOrderedDitherImage(self, threshold_map)
    end

    def polaroid(brush : Brush, caption : String, angle : Float64, method : LibMagick::PixelInterpolateMethod = :average)
      LibMagick.magickPolaroidImage(self, brush, caption, angle, method)
    end

    def polynomial(n_terms : Int, terms : Float64)
      LibMagick.magickPolynomialImage(self, n_terms, terms)
    end

    def posterize(levels : Int, dither_method : LibMagick::DitherMethod = :none)
      LibMagick.magickPosterizeImage(self, levels, dither_method)
    end

    def preview_transform(type : LibMagick::PreviewType)
      wand = LibMagick.magickPreviewImages(self, type)
      Wand.new(wand)
    end

    def quantize(n_colors : Int, colorspace : LibMagick::ColorspaceType, treedepth : Int, dither_method : LibMagick::DitherMethod = :none, measure_error : Bool = false)
      LibMagick.magickQuantizeImage(self, n_colors, colorspace, treedepth, dither_method, measure_error)
    end

    def quantize_all(n_colors : Int, colorspace : LibMagick::ColorspaceType, treedepth : Int, dither_method : LibMagick::DitherMethod = :none, measure_error : Bool = false)
      LibMagick.magickQuantizeImages(self, n_colors, colorspace, treedepth, dither_method, measure_error)
    end

    def query_fonts(pattern : String)
      arr_ptr = LibMagick.magickQueryFonts(pattern, out count)
      ptr_to_string_array(arr_ptr, count)
    end

    def query_formats(pattern : String)
      arr_ptr = LibMagick.magickQueryFormats(pattern, out count)
      ptr_to_string_array(arr_ptr, count)
    end

    def range_threshold(low_black : Float64, low_white : Float64, hight_white : Float64, hight_black : Float64)
      LibMagick.magickRangeThresholdImage(self, low_black, low_white, hight_white, hight_black)
    end

    def rotational_blur(angle : Float64)
      LibMagick.magickRotationalBlurImage(self, angle)
    end

    def raise(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickRaiseImage(self, width, height, x, y, true)
    end

    def lower(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickRaiseImage(self, width, height, x, y, false)
    end

    def random_threshold(low : Float64, high : Float64)
      LibMagick.magickRandomThresholdImage(self, low, hight)
    end

    def read(filename : String)
      LibMagick.magickReadImage(self, filename)
    end

    def read(buffer : IO)
      str = buffer.gets_to_end
      bytes = str.to_slice
      LibMagick.magickReadImageBlob(self, bytes.to_unsafe, bytes.size)
    end

    def read(buffer : Bytes)
      LibMagick.magickReadImageBlob(self, buffer.to_unsafe, buffer.size)
    end

    def remap(affinity : Wand, method : LibMagick::DitherMethod = :none)
      LibMagick.magickRemapImage(self, affinity, method)
    end

    def remove
      LibMagick.magickRemoveImage(self)
    end

    def resample(x_resolution : Float64, y_resolution : Float64, filter : LibMagick::FilterType)
      LibMagick.magickResampleImage(self, x_resolution, y_resolution, filter)
    end

    def reset_page(page : String)
      LibMagick.magickResetImagePage(self, page)
    end

    def resize(width : Int, height : Int, filter : LibMagick::FilterType = :lanczos, preserve_aspect_ratio : Bool = false)
      width, height = self.preserve_aspect_ratio(self.width, self.height, width, height) if preserve_aspect_ratio
      LibMagick.magickResizeImage(self, width, height, filter)
    end

    def roll(x : Int, y : Int)
      LibMagick.magickRollImage(self, x, y)
    end

    def rotate(background : Pixel, degrees : Float64)
      LibMagick.magickRotateImage(self, background, degrees)
    end

    def sample(width : Int, height : Int)
      LibMagick.magickSampleImage(self, width, height)
    end

    def scale(width : Int, height : Int)
      LibMagick.magickScaleImage(self, width, height)
    end

    def segment(colorspace : LibMagick::ColorspaceType, cluster_threshold : Float64, smooth_threshold : Float64, verbose = false)
      LibMagick.magickSegmentImage(self, colorspace, verbose, cluster_threshold, smooth_threshold)
    end

    def selective_blur(radius : Float64, sigma : Float64, threshold : Float64)
      LibMagick.magickSelectiveBlurImage(self, radius, sigma, threshold)
    end

    def separate(channel : LibMagick::ChannelType)
      LibMagick.magickSeparateImage(self, channel)
    end

    def sepia(threshold : Float64)
      LibMagick.magickSepiaToneImage(self, threshold)
    end

    def set(image : Wand)
      LibMagick.magickSetImage(self, image)
    end

    def shade(azimuth : Float64, elevation : Float64, gray : Bool = false)
      LibMagick.magickShadeImage(self, gray, azimuth, elevation)
    end

    def shadow(alpha : Float64, sigma : Float64, x : Int, y : Int)
      LibMagick.magickShadowImage(self, alpha, sigma, x, y)
    end

    def sharpen(radius : Float64, sigma : Float64)
      LibMagick.magickSharpenImage(self, radius, sigma)
    end

    def shave(width : Int, height : Int)
      LibMagick.magickShaveImage(self, width, height)
    end

    def shear(background : Pixel, x : Float64, y : Float64)
      LibMagick.magickShearImage(self, background, x, y)
    end

    def sigmoidal_constrast(alpha : Float64, beta : Float64, sharpen : Bool = false)
      LibMagick.magickSigmoidalContrastImage(self, sharpen, alpha, beta)
    end

    def image_similarity(reference : Wand, metric : LibMagick::MetricType, threshold : Float64)
      LibMagick.magickSimilarityImage(self, image, metric, threshold, out offset, out similarity)
      {offset: offset, similarity: similarity}
    end

    def sketch(radius : Float64, sigma : Float64, angle : Float64)
      LibMagick.magickSketchImage(self, radius, sigma, angle)
    end

    def smush(offset : Int, stack : Bool = false)
      LibMagick.magickSmushImages(self, stack, offset)
    end

    def solarize(threshold : Float64)
      LibMagick.magickSolarizeImage(self, threshold)
    end

    def sparse_color(method : LibMagick::SparseColorMethod, args : Array(Float64))
      LibMagick.magickSparseColorImage(self, method, args.size, args.to_unsafe)
    end

    def splice(width : Int, height : Int, x : Int, y : Int)
      LibMagick.magickSpliceImage(self, width, height, x, y)
    end

    def spread(method : LibMagick::PixelInterpolateMethod, radius : Float64)
      LibMagick.magickSpreadImage(self, method, radius)
    end

    def statistic(type : LibMagick::StatisticType, width : Int, height : Int)
      LibMagick.magickStatisticImage(self, type, width, height)
    end

    def stego(watermark : Wand, offset : Int)
      LibMagick.magickSteganoImage(self, watermark, offset)
    end

    def stereo(offset : Wand)
      LibMagick.magickStereoImage(self, offset)
    end

    def strip
      LibMagick.magickStripImage(self)
    end

    def swirl(degrees : Float64, method : LibMagick::PixelInterpolateMethod)
      LibMagick.magickSwirlImage(self, degrees, method)
    end

    def texture(texture : Wand)
      LibMagick.magickTextureImage(self, texture)
    end

    def threshold(threshold : Float64)
      LibMagick.magickThresholdImage(self, threshold)
    end

    def threshold_channel(channel : LibMagick::ChannelType, threshold : Float64)
      LibMagick.magickThresholdImageChannel(self, channel, threshold)
    end

    def thumbnail(width : Int, height : Int)
      LibMagick.magickThumbnailImage(self, width, height)
    end

    def tint(tint : Pixel, blend : Pixel)
      LibMagick.magickTintImage(self, tint, blend)
    end

    def transform_colorspace(colorspace : LibMagick::ColorspaceType)
      LibMagick.magickTransformImageColorspace(self, colorspace)
    end

    def transparent_paint(target : Pixel, alpha : Float64, fuzz : Float64, invert : Bool = false)
      LibMagick.magickTransparentPaintImage(self, target, alpha, fuzz, invert)
    end

    def transpose
      LibMagick.magickTransposeImage(self)
    end

    def transverse
      LibMagick.magickTransverseImage(self)
    end

    def trim(fuzz : Float64)
      LibMagick.magickTrimImage(self, fuzz)
    end

    def collect_unique_colors
      LibMagick.magickUniqueImageColors(self)
    end

    def unsharp_mask(radius : Float64, sigma : Float64, gain : Float64, threshold : Float64)
      LibMagick.magickUnsharpMaskImage(self, radius, sigma, gain, threshold)
    end

    def vignette(radius : Float64, sigma : Float64, x : Int, y : Int)
      LibMagick.magickVignetteImage(self, radius, sigma, x, y)
    end

    def wave(amplitude : Float64, length : Float64, method : LibMagick::PixelInterpolateMethod)
      LibMagick.magickWaveImage(self, amplitude, length, method)
    end

    def wavelet_denoise(threshold : Float64, softness : Float64)
      LibMagick.magickWaveletDenoiseImage(self, threshold, softness)
    end

    def white_threshold(threshold : Pixel)
      LibMagick.magickWhiteThresholdImage(self, threshold)
    end

    def write(path : String)
      LibMagick.magickWriteImage(self, path)
    end

    def clone
      wand = LibMagick.cloneMagickWand(self)
      Image.new(wand)
    end

    def clear
      LibMagick.clearMagickWand(self)
    end

    def size
      LibMagick.magickGetNumberImages(self).to_i
    end

    def to_io
      IO::Memory.new(blob)
    end

    def to_unsafe_image
      LibMagick.getImageFromMagickWand(self)
    end

    def to_unsafe
      @wand
    end

    def hash
      signature.hash
    end

    def finalize
      LibMagick.destroyMagickWand(self)
    end

    class ReadError < Exception; end
  end
end
