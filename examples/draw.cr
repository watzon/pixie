# ---------------------------------------------------------------------------- #
# Example:     draw
# Author:      watzon
# Description: Draw some shapes using Pixie::Brush
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img = Pixie::Image.new(640, 480, Pixie::Pixel::ORANGE)
img.draw do |d|
  d.set_stroke_color(Pixie::Pixel::RED)
  d.set_stroke_width(4)
  d.set_stroke_antialias(true)
  d.set_fill_color(Pixie::Pixel::RED)
  d.rectangle(300, 200, 500, 300)
  d.set_fill_color(Pixie::Pixel::BLUE)
  d.circle(150, 150, 200, 200)
  d.set_stroke_color(Pixie::Pixel::GREEN)
  d.line(20, 20, 100, 400)
end
img.write("output.jpg")
