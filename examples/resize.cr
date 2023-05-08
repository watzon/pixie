# ---------------------------------------------------------------------------- #
# Example:     resize
# Author:      watzon
# Description: Do a simple resize of an image.
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img = Pixie::Image.new("spec/fixtures/default.jpg")

w = img.width
h = img.height
puts "- Resolution: #{w} x #{h}"

img.compression_quality = 80
img.resize(w // 2, h // 2, :lanczos)

# # or simply scale with:
# img.scale(wand, w // 2, h // 2)

img.write("output.jpg")
