module Pixie
  class Image
    def initialize(@image : LibMagick::Image*)
    end

    def self.new(set : ImageSet)
      image = LibMagick.getImageFromMagickWand(set)
      new image
    end
  end
end
