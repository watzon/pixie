# ---------------------------------------------------------------------------- #
# Example:     resize
# Author:      Mat
# Description: Resize image
# ---------------------------------------------------------------------------- #

require "../src/pixie"

set = Pixie::ImageSet.new("../spec/test2.jpg")
w = set.image_width
h = set.image_height
puts "- Resolution: #{w} x #{h}"
set.resize_image(w // 2, h // 2, :lanczos)
# # or simply scale with:
# set.scale_image(wand, w // 2, h // 2)
set.image_compression_quality = 80
set.write_image("output.jpg")
