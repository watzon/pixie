# ---------------------------------------------------------------------------- #
# Example:     info
# Author:      watzon
# Description: Displays information about an image.
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img = Pixie::Image.new("spec/fixtures/animation.gif")

# char* functions
puts "- MagickGetImageFilename: " + img.filename
puts "- MagickGetImageFormat: " + img.format
puts "- MagickGetImageSignature: " + img.signature
puts "- MagickIdentifyImage:\n" + img.identify
puts
# int functions
puts "- GetImageWidth: " + img.width.to_s
puts "- GetImageHeight: " + img.height.to_s
puts "- GetImageColors: " + img.colors.to_s
puts "- GetImageCompressionQuality: " + img.compression_quality.to_s
puts "- GetImageDelay: " + img.delay.to_s
puts "- GetImageDepth: " + img.depth.to_s
puts "- GetImageIterations: " + img.iterations.to_s
puts "- GetImageScene: " + img.scene.to_s
puts "- GetImageTicksPerSecond: " + img.ticks_per_second.to_s
puts "- GetNumberImages: " + img.size.to_s
puts
# enum functions
puts "- GetImageCompression: " + img.compression.to_s
puts "- GetImageType: " + img.type.to_s
puts
