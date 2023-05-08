<div align="center">
  <img src="./assets/pixie-logo-small.png" alt="pixie logo">
</div>

# Pixie

Crystal bindings to ImageMagick 7. The goal is to have a full Crystal interface to the MagickWand API. Many functions also work with ImageMagick 6, but some do not. I would like to eventually find a way to support both versions.

**NOTE**: This is a large undertaking as ImageMagick is a massive library. Contributions are always welcome!

## Requirements

- *libMagickWand-7* must be installed, for instructions on Debian/Ubuntu see [this tutorial](https://www.tecmint.com/install-imagemagick-on-debian-ubuntu/).
- *pkg-config* must be available

## Installation

- Add this to your application's `shard.yml`:

```yaml
dependencies:
  pixie:
    github: watzon/pixie
```

## Usage

The following usage information is based on the usage information for the [mini_magick](https://github.com/minimagick/minimagick) gem, but using Pixie instead.

First a basic example of resizing an image

```crystal
require "pixie"

image = Pixe::Image.new("input.jpg")
image.resize("100x100")
image.set_format "png"
image.write("output.png")
```

`Image.new` can be called with a file path, an IO, or a raw buffer. If a file path is given, the file will be read and converted into `Pixie::Image`. The `resize` method is then used to resize the image, which is then converted to a PNG and written to disk.

I have opted to not give `Pixie` the ability to read an image from a URL, but doing so is trivial:

```crystal
require "pixie"
require "http/client"

raw_image = HTTP::Client.get("https://example.com/image.jpg").body
image = Pixie::Image.new(raw_image.to_slice)
```

As `Pixie` uses `LibMagickWand` directly and not the imagemagick CLI (like `mini_magick` does), it is much faster. There is also no need to have methods like `combine_options` as all options are applied immediately to the in-memory image representation, and don't have to be grouped together to be sent off to a CLI.

### Attributes

`Pixie::Image` has several attributes that can be used to get information about the image.

```crystal
image = Pixie::Image.new("input.jpg")
image.width # => 100
image.height # => 100
image.format # => "JPEG"
image.bytesize # => 12345
image.size # => 1 (this represents the number of images in the collection)
image.colorspace # => "DirectClass sRGB"
image.exif # => {"DateTimeOriginal" => "2013:09:04 08:03:39", ...}
image.resolution # => {72, 72}
image.signature # => "60a7848c4ca6e36b8e2c5dea632ecdc29e9637791d2c59ebf7a54c0c6a74ef7e"
```

If you need more control, you can access the [raw image attributes](https://imagemagick.org/script/escape.php).

```crystal
image = Pixie::Image.new("input.jpg")
image["%[gamma]"] # "0.9"
image["%[fx:mean]"] # "0.123456"
```

### Pixels

With `Pixie` you can retrieve a matrix of image pixels, where each item in the matrix is an array of values (those values being dependant on the mapping you set).

```crystal
image = Pixie::Image.new("input.jpg")
pixels[3][2][1] # the green channel value from the 4th-row, 3rd-column pixel
```

It can be called at any point, including after transformations have been applied.

```crystal
image = Pixie::Image.new("input.jpg")
image.crop("100x100+10+10")
image.set_colorspace "Gray"
pixels = image.get_pixels(map: "I")
```

### Pixels to Image

Sometimes you may want to create an image from a matrix of pixels. This can be done with `Pixie::Image.import_pixels`.

```crystal
image = Pixie::Image.new("input.jpg")
pixels = image.get_pixels
new_image = Pixie::Image.import_pixels(pixels.flatten, width: image.width, height: image.height, map: "RGB", depth: 8)
```

### Composite

`Pixie` also supports compositing images together.

```crystal
first_image = Pixie::Image.new("input.jpg")
second_image = Pixie::Image.new("input2.jpg")
result = first_image.composite(second_image, :over, 20, 20)
result.write("output.jpg")
```

### Layers/Frames/Pages

For multilayer images, you can access its layers.

```crystal
image = Pixie::Image.new("input.gif")
image.layers # => [Pixie::Image, Pixie::Image, Pixie::Image]
```

This works with GIFs, PDFs, PSDs, and other formats that support layers.

## More examples

See the [examples](./examples) folder for several interesting examples of what you can do with Pixie. Included are:

- [composite](./examples/composite.cr) - composite two images together
- [draw](./examples/draw.cr) - draw some shapes on an image
- [info](./examples/info.cr) - get info about an image
- [extend](./examples/extend.cr) - extend an image to a specific size
- [floodfill](./examples/floodfill.cr) - floodfill an image
- [info](./examples/info.cr) - get info about an image
- [morphology](./examples/morphology.cr) - apply a morphology to an image
- [pixels](./examples/pixels.cr) - get an images pixels and convert it to an ascii art representation for the terminal
- [resize](./examples/resize.cr) - resize an image
- [server](./examples/server.cr) - start a web server that will generate random images
- [text](./examples/text.cr) - draw some text on an image
- [tiltshift](./examples/tiltshift.cr) - apply a tiltshift effect to an image

## Contributors

- [watzon](https://github.com/watzon) - creator, maintainer
- [Mattia Roccoberton](http://blocknot.es) - author of [blocknotes/magickwand-crystal](https://github.com/blocknotes/magickwand-crystal)
