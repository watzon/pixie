# ---------------------------------------------------------------------------- #
# Example:     text
# Author:      watzon
# Description: Draw text on an image
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img = Pixie::Image.new("spec/fixtures/default.jpg")
Brush = Pixie::Brush.new
pixel = Pixie::Pixel::WHITE

Brush.set_fill_color(pixel)
Brush.set_font("Verdana-Bold-Italic")
Brush.set_font_size(40)
Brush.set_text_antialias(true)
Brush.annotation(5, 65, "It's Magick")

img.draw(Brush)
img.trim(0.0)
img.write("output.png")
