# ---------------------------------------------------------------------------- #
# Example:     server
# Author:      watzon
# Description: Generate an image and serve it with HTTP::Server
# ---------------------------------------------------------------------------- #

require "../src/pixie"
require "http/server"

def random_color
  String.build(7) do |str|
    str << '#' << Random.new.hex(3)
  end
end

server = HTTP::Server.new do |context|
  context.response.content_type = "image/jpeg"

  pixel = Pixie::Pixel.from_hex(random_color)
  img = Pixie::Image.new(640, 480, pixel)
  img.set_format("JPEG")
  context.response.write img.blob
end

server.listen(3000)
