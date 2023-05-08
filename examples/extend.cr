# ---------------------------------------------------------------------------- #
# Example:     extend
# Author:      watzon
# Description: Extend the image, adding a background color for the new areas.
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img = Pixie::Image.new("spec/fixtures/default.jpg")
pixel = Pixie::Pixel.parse("magenta")
img.background_color = pixel
img.extend(840, 680, -100, -100)
img.write("output.png")
