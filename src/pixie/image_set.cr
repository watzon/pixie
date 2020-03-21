module Pixie
  class ImageSet
    include Enumerable(Image)

    # The location of the current working file
    getter path : String?

    @wand : LibMagick::MagickWand*

    def initialize
      @wand = LibMagick.newMagickWand
    end

    def initialize(@wand : LibMagick::MagickWand*)
    end

    def initialize(image : Image | LibMagick::Image*)
      @wand = LibMagick.newMagickWandFromImage(image)
    end

    def initialize(input : String | Bytes | File | IO)
      @wand = LibMagick.newMagickWand

      case input
      when String
        LibMagick.magickReadImage(@wand, input)
      when File
        @path = input.path
        fd = LibC.fdopen(input.fd, input.mode)
        LibMagick.magickReadImageFile(@wand, fd)
      when IO
        str = input.gets_to_end
        bytes = str.to_slice
        LibMagick.magickReadImageBlob(@wand, bytes.to_unsafe, bytes.size)
      else # Bytes
        LibMagick.magickReadImageBlob(@wand, input.to_unsafe, input.size)
      end
    end

    def to_image
      Image.new(LibMagick.getImageFromMagickWand(self))
    end

    def each(&block : Image ->)
      start_pos = self.pos
      self.rewind
      loop do
        yield to_image
        break unless next_image
      end
      self.pos = start_pos
      nil
    end

    def succ
      next_image
    end

    def pred
      previous_image
    end

    def pos
      LibMagick.magickGetIteratorIndex(self).to_i
    end

    def pos=(index : Int32)
      LibMagick.magickSetIteratorIndex(self, index)
    end

    def rewind
      LibMagick.magickResetIterator(self)
    end

    def image_width
      LibMagick.magickGetImageWidth(self).to_i
    end

    def image_height
      LibMagick.magickGetImageHeight(self).to_i
    end

    def image_has_alpha_channel?
      LibMagick.magickGetImageAlphaChannel(self)
    end

    def image_alpha_channel=(value : LibMagick::AlphaChannelOption)
      LibMagick.magickSetImageAlphaChannel(self, value)
    end

    def image_background_color
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageBackgroundColor(self, pw)
      pw.value
    end

    def image_background_color=(background : Pixel)
      LibMagick.magickSetImageBackgroundColor(self, background)
    end

    def image_blob
      size = self.image_bytesize
      data = LibMagick.magickGetImageBlob(self, pointerof(size))
      Bytes.new(data, size)
    end

    def image_blue_primary
      LibMagick.magickGetImageBluePrimary(self, out x, out y, out z)
      {x: x, y: y, z: z}
    end

    def image_blue_primary=(values)
      if values.is_a?(Hash | NamedTuple)
        x, y, z = values["x"], values["y"], values["z"]
      else
        x, y, z = values
      end
      LibMagick.magickSetImageBluePrimary(self, x, y, z)
    end

    def image_green_primary
      LibMagick.magickGetImageGreenPrimary(self, out x, out y, out z)
      {x: x, y: y, z: z}
    end

    def image_green_primary=(values)
      if values.is_a?(Hash | NamedTuple)
        x, y, z = values["x"], values["y"], values["z"]
      else
        x, y, z = values
      end
      LibMagick.magickSetImageGreenPrimary(self, x, y, z)
    end

    def image_red_primary
      LibMagick.magickGetImageRedPrimary(self, out x, out y, out z)
      {x: x, y: y, z: z}
    end

    def image_red_primary=(values)
      if values.is_a?(Hash | NamedTuple)
        x, y, z = values["x"], values["y"], values["z"]
      else
        x, y, z = values
      end
      LibMagick.magickSetImageRedPrimary(self, x, y, z)
    end

    # TODO: Return color or PixelWand wrapper
    def image_border_color
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageBorderColor(self, pw)
      pw.value
    end

    def image_border_color=(color : Pixel)
      LibMagick.magickSetImageBorderColor(self, color)
    end

    def image_features(distance)
      LibMagick.magickGetImageFeatures(self, distance).try &.value
    end

    # TODO: Figure out how to specify a channel
    def image_kurtosis
      LibMagick.magickGetImageKurtosis(self, out kurtosis, out skewness)
      { kurtosis: kurtosis, skewness: skewness }
    end

    def image_mean
      LibMagick.magickGetImageMean(self, out mean, out standard_deviation)
      { mean: mean, standard_deviation: standard_deviation }
    end

    def image_range
      LibMagick.magickGetImageRange(self, out minima, out maxima)
      { minima: minima, maxima: maxima }
    end

    def image_statistics(channel : LibMagick::ChannelType)
      stats = LibMagick.magickGetImageStatistics(self)
      (stats + channel.value).value
    end

    def image_color=(color : Pixel)
      LibMagick.magickSetImageColor(self, color)
    end

    def image_colormap_color(index)
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageColormapColor(self, index, pw)
      pw.value
    end

    def image_set_colormap_color(index : Int32, color : Pixel)
      LibMagick.magickSetImageColormapColor(self, index, color)
    end

    def image_n_unique_colors
      LibMagick.magickGetImageColors(self).to_i
    end

    def image_colorspace
      LibMagick.magickGetImageColorspace(self)
    end

    def image_colorspace=(colorspace : LibMagick::ColorspaceType)
      LibMagick.magickSetImageColorspace(self colorspace)
    end

    def image_composite_operator
      LibMagick.magickGetImageCompose(self)
    end

    def image_composite_operator=(op : LibMagick::CompositeOperator)
      LibMagick.magickSetImageCompose(self, op)
    end

    def image_compression
      LibMagick.magickGetImageCompression(self)
    end

    def image_compression=(value : LibMagick::CompressionType)
      LibMagick.magickSetImageCompression(self, value)
    end

    def image_compression_quality
      LibMagick.magickGetImageCompressionQuality(self).to_i
    end

    def image_compression_quality=(quality : Int32)
      LibMagick.magickSetImageCompressionQuality(self, quality)
    end

    def image_delay
      LibMagick.magickGetImageDelay(self).to_i
    end

    def image_delay=(val : Int32)
      LibMagick.magickSetImageDelay(self, val)
    end

    def image_depth
      LibMagick.magickGetImageDepth(self).to_i
    end

    def image_depth=(val : Int32)
      LibMagick.magickSetImageDepth(self, val)
    end

    def image_dispose
      LibMagick.magickGetImageDispose
    end

    def image_dispose=(val : LibMagick::DisposeType)
      LibMagick.magickSetImageDispose(self, val)
    end

    def image_distortion(reference : Wand, metric : LibMagick::MetricType)
      LibMagick.magickGetImageDistortion(self, reference, metric, out distortion)
      distortion.to_i
    end

    def image_distortions(reference : Wand, metric : LibMagick::MetricType, channel : LibMagick::ChannelType)
      distortions = LibMagick.magickGetImageDistortions(self, reference, metric)
      (distortions + channel.value).value
    end

    def image_endian
      LibMagick.magickGetImageEndian(self)
    end

    def image_endian=(val : LibMagick::EndianType)
      LibMagick.magickSetImageEndian(self, val)
    end

    def image_set_extent(width : Int32, height : Int32)
      LibMagick.magickSetImageExtent(self, width, height)
    end

    def filename
      String.new(LibMagick.magickGetFilename(self))
    end

    def filename=(name : String)
      LibMagick.magickSetFilename(self, name)
    end

    def image_filename
      String.new(LibMagick.magickGetImageFilename(self))
    end

    def image_filename=(val : String)
      LibMagick.magickSetImageFilename(self, val)
    end

    def image_format
      String.new(LibMagick.magickGetImageFormat(self))
    end

    def image_format=(val : String)
      LibMagick.magickSetImageFormat(self, val)
    end

    def image_fuzz
      LibMagick.magickGetImageFuzz(self)
    end

    def image_fuzz=(val : Float64)
      LibMagick.magickSetImageFuzz(self, val)
    end

    def image_gamma
      LibMagick.magickGetImageGamma(self)
    end

    def image_gamma=(val : Float64)
      LibMagick.magickSetImageGamma(self, val)
    end

    def image_gravity
      LibMagick.magickGetImageGravity(self)
    end

    def image_gravity=(val : Float64)
      LibMagick.magickSetImageGravity(self, val)
    end

    def image_histogram(n_colors = nil)
      n_colors ||= n_unique_colors
      colors = n_colors.to_u64
      wands = LibMagick.magickGetImageHistogram(self, pointerof(colors))
      Array(Pixel).new(n_colors) do |i|
        (wands + i).value.value
      end
    end

    def image_interlace_scheme
      LibMagick.magickGetImageInterlaceScheme(self)
    end

    def image_interlace_scheme=(val : LibMagick::InterlaceType)
      LibMagick.magickSetImageInterlaceScheme(self, val)
    end

    def image_pixel_interpolation_method
      LibMagick.magickGetImageInterpolateMethod(self)
    end

    def image_pixel_interpolation_method=(val : LibMagick::PixelInterpolateMethod)
      LibMagick.magickSetImagePixelInterpolateMethod(self, val)
    end

    def image_iterations
      LibMagick.magickGetImageIterations(self).to_i
    end

    def image_iterations=(val : Int32)
      LibMagick.magickSetImageIterations(self, val)
    end

    def image_bytesize
      LibMagick.magickGetImageLength(self, out size)
      size.to_i
    end

    def image_matte=(val : Bool)
      LibMagick.magickSetImageMatte(self, val)
    end

    def image_matte_color
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImageMatteColor(self, pw)
      pw.value
    end

    def image_matte_color=(val : Pixel)
      LibMagick.magickSetImageMatteColor(self, val)
    end

    def image_orientation
      LibMagick.magickGetImageOrientation(self)
    end

    def image_orientation=(val : LibMagick::OrienationType)
      LibMagick.magickSetImageOrientation(self, val)
    end

    def image_page
      LibMagick.magickGetImagePage(self, out width, out height, out x, out y)
      {width: width, height: height, x: x, y: y}
    end

    def image_set_page(width : Int32, height : Int32, x : Int32, y : Int32)
      LibMagick.magickSetImagePage(self, width, height, x, y)
    end

    def image_pixel_color(x, y)
      pw = LibMagick.newPixelWand
      LibMagick.magickGetImagePixelColor(self, x, y, pw)
      pw.value
    end

    def image_set_pixel_color(x : Int32, y : Int32, color : Pixel)
      LibMagick.magickSetImagePixelColor(self, x, y, color)
    end

    def image_set_progress_monitor(&block : LibC::Char*, MagickOffsetType, LibC::SizeT, Void* -> Bool)
      client_data = Pointer(Void).malloc(1)
      LibMagick.magickSetImageProgressMonitor(self, block.pointer, client_data)
    end

    def image_crop(width, height, x, y)
      wand = LibMagick.magickGetImageRegion(self, width, height, x, y)
      new(wand)
    end

    def image_intent
      LibMagick.magickGetImageRenderingIntent(self)
    end

    def image_intent=(val : LibMagick::RenderingIntent)
      LibMagick.magickSetImageRenderingIntent(self, val)
    end

    def image_resolution
      LibMagick.magickGetImageResolution(self, out x, out y)
      {x: x, y: y}
    end

    def image_set_resolution(x : Float64, y : Float64)
      LibMagick.magickSetImageResolution(self, x, y)
    end

    def image_scene
      LibMagick.magickGetImageScene(self).to_i
    end

    def image_scen=(scene : Int32)
      LibMagick.magickSetImageScene(self, scene)
    end

    def image_signature
      String.new(LibMagick.magickGetImageSignature(self))
    end

    def image_ticks_per_second
      LibMagick.magickGetImageTicksPerSecond(self).to_i
    end

    def image_ticks_per_second=(val : Int32)
      LibMagick.magickSetImageTicksPerSecond(self, val)
    end

    def image_type
      LibMagick.magickGetImageType(self)
    end

    def image_type=(val : LibMagick::ImageType)
      LibMagick.magickSetImageType(self, val)
    end

    def image_units
      LibMagick.magickGetImageUnits(self)
    end

    def image_units=(val : LibMagick::ResolutionType)
      LibMagick.magickSetImageUnits(self, val)
    end

    def image_virtual_pixel_method
      LibMagick.magickGetImageVirtualPixelMethod(self)
    end

    def image_virtual_pixel_method=(val : LibMagick::VirtualPixelMethod)
      LibMagick.magickSetImageVirtualPixelMethod(self, val)
    end

    def image_white_point
      LibMagick.magickGetImageWhitePoint(self, out x, out y, out z)
      {x: x, y: y, z: z}
    end

    def image_set_white_point(x : Float64, y : Float64, z : Float64)
      LibMagick.magickSetImageWhitePoint(self, x, y, z)
    end

    def n_images
      LibMagick.magickGetNumberImages(self).to_i
    end

    def image_total_ink_density
      LibMagick.magickGetImageTotalInkDensity(self)
    end

    # TODO
    # def hald_clut(hald_coder : HaldCoder)
    #   LibMagick.magickHaldClutImage(self, hald_coder)
    # end

    def has_next_image?
      LibMagick.magickHasNextImage(self)
    end

    def has_previous_image?
      LibMagick.magickHasPreviousImage(self)
    end

    def image_hough_line(width, height, threshold)
      LibMagick.magickHoughLineImage(self, width, height, threshold)
    end

    def image_identify
      String.new(LibMagick.magickIdentifyImage(self))
    end

    def identify_image_type
      LibMagick.magickIdentifyImageType(self)
    end

    def implode_image(radius, method : PixelInterpolateMethod = :average)
      LibMagick.magickImplodeImage(self, radius, method)
    end

    def import_image_pixels(pixels : Iterable(Iterable(Int)), x, y, map : String = "RGB")
      unless pixels.all? { |p| p.size == pixels.first.size }
        raise "Rows must be the same size"
      end

      row_count = pixels.size
      col_count = pixels[0].size

      unsafe = pixels.map(&.to_unsafe).to_unsafe
      LibMagick.magickImportImagePixels(self, x, y, col_count, row_count, map, unsafe)
    end

    def interpolative_resize_image(width, height, method : LibMagick::PixelInterpolateMethod = :average)
      LibMagick.magickInterpolativeResizeImage(self, width, height, method)
    end

    def inverse_fourier_transform_image(phase_image : Pixie::Wand, magnitude = false)
      LibMagick.magickInverseFourierTransformImage(self, phase_image, magnitude)
    end

    def kuwahara_filter_image(radius : Float64, sigma : Float64)
      LibMagick.magickKuwaharaImage(self, radius, sigma)
    end

    def label_image(label : String)
      LibMagick.magickLabelImage(self, label)
    end

    def level_image(black_point : Float64, gamma : Float64, white_point : Float64)
      LibMagick.magickLevelImage(self, black_point, gamma, white_point)
    end

    def level_image_colors(black_color : Pixel, white_color : Pixel, invert = false)
      LibMagick.magickLevelImageColors(self, black_color, white_color, invert)
    end

    def levelize_image(black_point : Float64, white_point : Float64, gamma : Float64)
      LibMagick.magickLevelizeImage(self, black_point, white_point, gamma)
    end

    def linear_stretch_image(black_point : Float64, white_point : Float64)
      LibMagick.magickLinearStretchImage(self, black_point, white_point)
    end

    def liquid_rescale_image(width : Int32, height : Int32, delta_x : Float64 = 0.0, rigidity : Float64 = 0.0)
      LibMagick.magickLiquidRescaleImage(self, width, height, delta_x, rigidity)
    end

    def enhance_local_contrast_image(radius : Float64, strength : Float64)
      LibMagick.magickLocalContrastImage(self, radius, strength)
    end

    def magnify_image
      LibMagick.magickMagnifyImage(self)
    end

    def mean_shift_image(width : Int32, height : Int32, color_distance : Float64)
      LibMagick.magickMeanShiftImage(self, width, height, color_distance)
    end

    def merge_image_layers(method : LibMagick::LayerMethod = :merge)
      LibMagick.magickMergeImageLayers(self, method)
    end

    def minify_image
      LibMagick.magickMinifyImage(self)
    end

    def modulate_image(brightness : Float64, saturation : Float64, hue : Float64)
      LibMagick.magickModulateImage(self, brightness, saturation, hue)
    end

    def montage_image(drawing_wand, geometry : String, thumb_geometry : String, mode : LibMagick::MontageMode, frame : String)
      LibMagick.magickMontageImage(self, drawing_wand, geometry, thumb_geometry, mode, frame)
    end

    def morph_images(n_frames : Int32)
      wand = LibMagick.magickMorphImages(self, n_frames)
      new(wand)
    end

    def morphology_method_image(method : LibMagick::MorphologyMethod, iterations : Int32, kernel : LibMagick::KernelInfo)
      LibMagick.magickMorphologyImage(self, method, iterations, kernel)
    end

    def motion_blur_image(radius : Float64, sigma : Float64, angle : Float64)
      LibMagick.magickMotionBlurImage(self, radius, sigma, angle)
    end

    def negate_image(gray : Bool)
      LibMagick.magickNegateImage(self, gray)
    end

    def new_image(columns : Int32, rows : Int32, background : Pixel)
      LibMagick.magickNewImage(columns, rows, background)
    end

    def next_image
      LibMagick.magickNextImage(self)
    end

    def next_image?
      next_image
    end

    def normalize_image
      LibMagick.magickNormalizeImage(self)
    end

    def oil_paint_image(radius : Float64, sigma : Float64)
      LibMagick.magickOilPaintImage(self, radius, sigma)
    end

    def opaque_paint_image(target_color : Pixel, fill_color : Pixel, fuzz : Float64, invert : Bool = false)
      LibMagick.magickOpaquePaintImage(self, target_color, fill_color, fuzz, invert)
    end

    def optimize_image_layers
      LibMagick.magickOptimizeImageLayers(self)
    end

    def optimize_image_transparency
      LibMagick.magickOptimizeImageTransparency(self)
    end

    def ordered_dither_image(threshold_map : String)
      LibMagick.magickOrderedDitherImage(self, threshold_map)
    end

    def polaroid_image(drawing_wand : LibMagick::DrawingWand, caption : String, angle : Float64, method : LibMagick::PixelInterpolateMethod = :average)
      LibMagick.magickPolaroidImage(self, drawing_wand, caption, angle, method)
    end

    def polynomial_image(n_terms : Int32, terms : Float64)
      LibMagick.magickPolynomialImage(self, n_terms, terms)
    end

    def posterize_image(levels : Int32, dither_method : LibMagick::DitherMethod = :none)
      LibMagick.magickPosterizeImage(self, levels, dither_method)
    end

    def preview_image_transform(type : LibMagick::PreviewType)
      wand = LibMagick.magickPreviewImages(self, type)
      Wand.new(wand)
    end

    def previous_image
      LibMagick.magickPreviousImage(self)
    end

    def previous_image?
      previous_image
    end

    def quantize_image(n_colors : Int32, colorspace : LibMagick::ColorspaceType, treedepth : Int32, dither_method : LibMagick::DitherMethod = :none, measure_error : Bool = false)
      LibMagick.magickQuantizeImage(self, n_colors, colorspace, treedepth, dither_method, measure_error)
    end

    def quantize_all_images(n_colors : Int32, colorspace : LibMagick::ColorspaceType, treedepth : Int32, dither_method : LibMagick::DitherMethod = :none, measure_error : Bool = false)
      LibMagick.magickQuantizeImages(self, n_colors, colorspace, treedepth, dither_method, measure_error)
    end

    def query_fonts(pattern : String)
      LibMagick.magickQueryFonts(self, pattern, out count)
      count.to_i
    end

    def query_formats(pattern : String)
      LibMagick.magickQueryFormats(self, pattern, out count)
      count.to_i
    end

    def range_threshold_image(low_black : Float64, low_white : Float64, hight_white : Float64, hight_black : Float64)
      LibMagick.magickRangeThresholdImage(self, low_black, low_white, hight_white, hight_black)
    end

    def rotational_blur_image(angle : Float64)
      LibMagick.magickRotationalBlurImage(self, angle)
    end

    def raise_image(width : Int32, height : Int32, x : Int32, y : Int32)
      LibMagick.magickRaiseImage(self, width, height, x, y, true)
    end

    def lower_image(width : Int32, height : Int32, x : Int32, y : Int32)
      LibMagick.magickRaiseImage(self, width, height, x, y, false)
    end

    def random_threshold_image(low : Float64, high : Float64)
      LibMagick.magickRandomThresholdImage(self, low, hight)
    end

    def read_image(filename : String)
      LibMagick.magickReadImage(self, filename)
    end

    def read_image(file : File)
      fd = LibC.fdopen(file.fd, file.mode)
      LibMagick.magickReadImageFile(@wand, fd)
    end

    def read_image(buffer : Bytes | IO)
      if buffer.is_a?(IO)
        str = buffer.gets_to_end
        bytes = str.to_slice
        LibMagick.magickReadImageBlob(self, bytes.to_unsafe, bytes.size)
      else # Bytes
        LibMagick.magickReadImageBlob(self, buffer.to_unsafe, buffer.size)
      end
    end

    def remap_image(affinity : Wand, method : LibMagick::DitherMethod = :none)
      LibMagick.magickRemapImage(self, affinity, method)
    end

    def remove_image
      LibMagick.magickRemoveImage(self)
    end

    def resample(x_resolution : Float64, y_resolution : Float64, filter : LibMagick::FilterType)
      LibMagick.magickResampleImage(self, x_resolution, y_resolution, filter)
    end

    def reset_image_page(page : String)
      LibMagick.magickResetImagePage(self, page)
    end

    def resize_image(width : Int32, height : Int32, filter : LibMagick::FilterType)
      LibMagick.magickResizeImage(self, width, height, filter)
    end

    def roll_image(x : Int32, y : Int32)
      LibMagick.magickRollImage(self, x, y)
    end

    def rotate_image(background : Pixel, degrees : Float64)
      LibMagick.magickRotateImage(self, background, degrees)
    end

    def sample_image(width : Int32, height : Int32)
      LibMagick.magickSampleImage(self, width, height)
    end

    def scale_image(width : Int32, height : Int32)
      LibMagick.magickScaleImage(self, width, height)
    end

    def segment_image(colorspace : LibMagick::ColorspaceType, cluster_threshold : Float64, smooth_threshold : Float64, verbose = false)
      LibMagick.magickSegmentImage(self, colorspace, verbose, cluster_threshold, smooth_threshold)
    end

    def selective_blur_image(radius : Float64, sigma : Float64, threshold : Float64)
      LibMagick.magickSelectiveBlurImage(self, radius, sigma, threshold)
    end

    def separate_image(channel : LibMagick::ChannelType)
      LibMagick.magickSeparateImage(self, channel)
    end

    def sepia_image(threshold : Float64)
      LibMagick.magickSepiaToneImage(self, threshold)
    end

    def set_image(image : Wand)
      LibMagick.magickSetImage(self, image)
    end

    def shade_image(azimuth : Float64, elevation : Float64, gray : Bool = false)
      LibMagick.magickShadeImage(self, gray, azimuth, elevation)
    end

    def shadow_image(alpha : Float64, sigma : Float64, x : Int32, y : Int32)
      LibMagick.magickShadowImage(self, alpha, sigma, x, y)
    end

    def sharpen_image(radius : Float64, sigma : Float64)
      LibMagick.magickSharpenImage(self, radius, sigma)
    end

    def shave_image(width : Int32, height : Int32)
      LibMagick.magickShaveImage(self, width, height)
    end

    def shear_image(background : Pixel, x : Float64, y : Float64)
      LibMagick.magickShearImage(self, background, x, y)
    end

    def sigmoidal_constrast_image(alpha : Float64, beta : Float64, sharpen : Bool = false)
      LibMagick.magickSigmoidalContrastImage(self, sharpen, alpha, beta)
    end

    def image_similarity(reference : Wand, metric : LibMagick::MetricType, threshold : Float64)
      LibMagick.magickSimilarityImage(self, image, metric, threshold, out offset, out similarity)
      {offset: offset, similarity: similarity}
    end

    def sketch_image(radius : Float64, sigma : Float64, angle : Float64)
      LibMagick.magickSketchImage(self, radius, sigma, angle)
    end

    def smush_image(offset : Int32, stack : Bool = false)
      LibMagick.magickSmushImages(self, stack, offset)
    end

    def solarize_image(threshold : Float64)
      LibMagick.magickSolarizeImage(self, threshold)
    end

    def sparse_color_image(method : LibMagick::SparseColorMethod, *args)
      LibMagick.magickSparseColorImage(self, args.size, pointerof(args))
    end

    def splice_image(width : Int32, height : Int32, x : Int32, y : Int32)
      LibMagick.magickSpliceImage(self, width, height, x, y)
    end

    def spread_image(method : LibMagick::PixelInterpolateMethod, radius : Float64)
      LibMagick.magickSpreadImage(self, method, radius)
    end

    def statistic_image(type : LibMagick::StatisticType, width : Int32, height : Int32)
      LibMagick.magickStatisticImage(self, type, width, height)
    end

    def stego_image(watermark : Wand, offset : Int32)
      LibMagick.magickSteganoImage(self, watermark, offset)
    end

    def stereo_image(offset : Wand)
      LibMagick.magickStereoImage(self, offset)
    end

    def strip_image
      LibMagick.magickStripImage(self)
    end

    def swirl_image(degrees : Float64, method : LibMagick::PixelInterpolateMethod)
      LibMagick.magickSwirlImage(self, degrees, method)
    end

    def texture_image(texture : Wand)
      LibMagick.magickTextureImage(self, texture)
    end

    def threshold_image(threshold : Float64)
      LibMagick.magickThresholdImage(self, threshold)
    end

    def threshold_image_channel(channel : LibMagick::ChannelType, threshold : Float64)
      LibMagick.magickThresholdImageChannel(self, channel, threshold)
    end

    def thumbnail_image(width : Int32, height : Int32)
      LibMagick.magickThumbnailImage(self, width, height)
    end

    def tint_image(tint : Pixel, blend : Pixel)
      LibMagick.magickTintImage(self, tint, blend)
    end

    def transform_image_colorspace(colorspace : LibMagick::ColorspaceType)
      LibMagick.magickTransformImageColorspace(self, colorspace)
    end

    def transparent_paint_image(target : Pixel, alpha : Float64, fuzz : Float64, invert : Bool = false)
      LibMagick.magickTransparentPaintImage(self, target, alpha, fuzz, invert)
    end

    def transpose_image
      LibMagick.magickTransposeImage(self)
    end

    def transverse_image
      LibMagick.magickTransverseImage(self)
    end

    def trim_image(fuzz : Float64)
      LibMagick.magickTrimImage(self, fuzz)
    end

    def collect_unique_image_colors
      LibMagick.magickUniqueImageColors(self)
    end

    def unsharp_mask_image(radius : Float64, sigma : Float64, gain : Float64, threshold : Float64)
      LibMagick.magickUnsharpMaskImage(self, radius, sigma, gain, threshold)
    end

    def vignette_image(radius : Float64, sigma : Float64, x : Int32, y : Int32)
      LibMagick.magickVignetteImage(self, radius, sigma, x, y)
    end

    def wave_image(amplitude : Float64, length : Float64, method : LibMagick::PixelInterpolateMethod)
      LibMagick.magickWaveImage(self, amplitude, length, method)
    end

    def wavelet_denoise_image(threshold : Float64, softness : Float64)
      LibMagick.magickWaveletDenoiseImage(self, threshold, softness)
    end

    def white_threshold_image(threshold : Pixel)
      LibMagick.magickWhiteThresholdImage(self, threshold)
    end

    def write_image(path : String)
      LibMagick.magickWriteImage(self, path)
    end

    def clone
      wand = LibMagick.cloneMagickWand(self)
      new(wand)
    end

    def clear
      LibMagick.clearMagickWand(self)
    end

    def size
      n_images
    end

    def to_unsafe
      @wand
    end

    def finalize
      LibMagick.destroyMagickWand(self)
    end
  end
end
