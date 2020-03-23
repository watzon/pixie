# ---------------------------------------------------------------------------- #
# Example:     extent
# Author:      Mat
# Description: Extent image
# ---------------------------------------------------------------------------- #

require "../src/pixie"

set = Pixie::ImageSet.new("../spec/test1.png")
pixel = Pixie::Pixel.parse("magenta")
set.image_background_color = pixel
set.extent_image(840, 680, -100, -100)
set.write_image("output.png")
