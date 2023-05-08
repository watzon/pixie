# ---------------------------------------------------------------------------- #
# Example:     flood_fill
# Author:      watzon
# Description: Flood fill an image with a color, or in this case transparency.
# ---------------------------------------------------------------------------- #

require "../src/pixie"

set = Pixie::Image.new("spec/fixtures/colors.png")
fc = Pixie::Pixel::TRANSPARENT
bc = Pixie::Pixel::RED
set.flood_fill_paint(fc, 20.0, bc, 150, 150, false)
set.write("output.png")
