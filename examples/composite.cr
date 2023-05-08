# ---------------------------------------------------------------------------- #
# Example:     composite
# Author:      watzon
# Description: Composite two images together
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img1 = Pixie::Image.new("spec/fixtures/default.jpg")
img2 = Pixie::Image.new("spec/fixtures/engine.png")

img1.composite(img2, :over, false, 50, 50)

img1.write("output.png")
