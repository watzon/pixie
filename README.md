<div align="center">
  <img src="./assets/pixie-logo-small.png" alt="pixie logo">
</div>

# Pixie

Crystal bindings to ImageMagick 7. The goal is to have a full Crystal interface to the MagickWand API.

**NOTE**: This is a large undertaking as ImageMagick is a massive library. Contributions are always welcome!

## Requirements

- *libMagickWand* must be installed
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

set = Pixie::ImageSet.new("test.png")

puts set.image_width
puts set.image_height
```

Scale image and save in JPEG format:

```crystal
require "pixie"

set = Pixie::ImageSet.new("test.png")
set.scale_image(320, 240)
set.write("test2.jpg")
```

Convert to grayscale:

```crystal
require "pixie"

set = Pixie::ImageSet.new("test.png")
set.transform_image_colorspace(:gray)
set.write("grayscale.jpg")
```

## More examples

See [examples](https://github.com/watzon/pixie/tree/master/examples) folder. There is also an example to generate an image on the fly with Kemal.

**Note:** This project was forked from [blocknotes/magickwand-crystal](https://github.com/blocknotes/magickwand-crystal) and all of the examples are still using the barebones ImageMagick api. New examples will be coming.

## Contributors

- [watzon](https://github.com/watzon) - creator, maintainer
- [Mattia Roccoberton](http://blocknot.es) - author of [blocknotes/magickwand-crystal](https://github.com/blocknotes/magickwand-crystal)
