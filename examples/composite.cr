# Composite two images together into a single image
require "../src/pixie"

set1 = Pixie::ImageSet.new("spec/test2.jpg")
set2 = Pixie::ImageSet.new("spec/test3.png")

set1.composite_image(set2, :over, false, 50, 50)

puts set1.write_image("output.png")
