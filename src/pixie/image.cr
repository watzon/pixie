module Pixie
  class Image
    def initialize(@image : LibMagick::Image*)
    end
  end
end
