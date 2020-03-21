module Pixie
  class Pixel
    def initialize(@pixel_wand : LibMagick::PixelWand*)
    end
  end
end
