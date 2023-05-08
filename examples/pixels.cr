# ---------------------------------------------------------------------------- #
# Example:     pixels
# Author:      watzon
# Description: Convert an image to ascii characters and print it to the terminal.
# ---------------------------------------------------------------------------- #

require "../src/pixie"
require "colorize"

term_width = `tput cols`.to_i
term_height = `tput lines`.to_i
img = Pixie::Image.new("spec/fixtures/tux.png")

# resize the image so it fits in the terminal
img.resize(term_width, term_height * 2, preserve_aspect_ratio: true)

# map varying intensities of gray to ascii characters using
def map_intensity(intensity, max_intensity = 255)
  chars = [" ", ".", ":", "-", "=", "+", "*", "#", "%", "&", "@"]
  index = (intensity / max_intensity.to_f * (chars.size - 1)).round.to_i
  chars[index]
end

pixels = img.pixels(map: "RGBI")
max_intensity = pixels.map { |row| row.map { |pixel| pixel[3] }.max }.max

# print the image to the terminal
pixels.each_with_index do |row, i|
  # only print every 3rd row to make the image look less squished
  next if i % 2 != 0
  row.each do |pixel|
    r, g, b = pixel[0..2]
    intensity = pixel[3]
    print map_intensity(intensity, max_intensity).colorize(r, g, b)
  end
  print "\n"
end
