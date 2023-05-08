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

Get image info:

```crystal
require "pixie"

set = Pixie::Image.new("test.png")

puts set.width
puts set.height
```

Scale image and save in JPEG format:

```crystal
require "pixie"

set = Pixie::Image.new("test.png")
set.scale(320, 240)
set.write("test2.jpg")
```

Convert to grayscale:

```crystal
require "pixie"

set = Pixie::Image.new("test.png")
set.transform_colorspace(:gray)
set.write("grayscale.jpg")
```

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
