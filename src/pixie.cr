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
