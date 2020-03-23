# ---------------------------------------------------------------------------- #
# Example:     kemal
# Author:      Mat
# Description: Generate an image on the fly in Kemal
# ---------------------------------------------------------------------------- #

require "kemal"
require "../src/pixie"

def random_color
  String.build(7) do |str|
    str << '#' << Random.new.hex(3)
  end
end

get "/" do |env|
  env.response.content_type = "image/jpeg"

  pixel = Pixie::Pixel.from_hex(random_color)
  set = Pixie::ImageSet.new(640, 480, pixel)
  set.image_format = "JPEG"
  buffer = set.image_blob
  io = IO::Memory.new
  io.write buffer
  io.to_s
end

Kemal.run
