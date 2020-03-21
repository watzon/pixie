require "./pixie/libs/*"
require "./pixie/ext/*"
require "./pixie/pixel"
require "./pixie/image"
require "./pixie/image_set"

# Initialize ImageMagick
LibMagick.magickWandGenesis

at_exit do
  LibMagick.magickWandTerminus
end

image1 = Pixie::ImageSet.new("./matti.jpg")
image1.filename = "matti.jpg"
puts image1.filename
