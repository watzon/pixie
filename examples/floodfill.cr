# ---------------------------------------------------------------------------- #
# Example:     floodfill
# Author:      Mat
# Description: Remove an image color
# ---------------------------------------------------------------------------- #

require "../src/pixie"

set = Pixie::ImageSet.new("../spec/test3.png")
fc = Pixie::Pixel.parse("none")
bc = Pixie::Pixel.parse("red")
set.flood_fill_paint_image(fc, 20.0, bc, 150, 150, false)
set.write_image("output.png")
