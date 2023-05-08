require "semantic_version"

require "./pixie/libs/*"
require "./pixie/helpers"
require "./pixie/pixel"
require "./pixie/brush"
require "./pixie/image"


# Initialize ImageMagick
LibMagick.magickWandGenesis

at_exit do
  LibMagick.magickWandTerminus
end

module Pixie
  def self.magick_version : SemanticVersion
    version = LibMagick.getMagickVersion(out version)
    version_str = String.new(version)
    parts = version_str.split(" ")
    SemanticVersion.parse(parts[1])
  end
end
