# ---------------------------------------------------------------------------- #
# Example:     info
# Author:      Mat
# Description: Get info from an image
# ---------------------------------------------------------------------------- #

require "../src/pixie"

set = Pixie::ImageSet.new("../spec/test1.png")
# char* functions
puts "- MagickGetImageFilename: " + set.image_filename
puts "- MagickGetImageFormat: " + set.image_format
puts "- MagickGetImageSignature: " + set.image_signature
puts "- MagickIdentifyImage:\n" + set.identify_image
puts
# int functions
puts "- GetImageWidth: " + set.image_width.to_s
puts "- GetImageHeight: " + set.image_height.to_s
puts "- GetImageColors: " + set.image_colors.to_s
puts "- GetImageCompressionQuality: " + set.image_compression_quality.to_s
puts "- GetImageDelay: " + set.image_delay.to_s
puts "- GetImageDepth: " + set.image_depth.to_s
puts "- GetImageIterations: " + set.image_iterations.to_s
puts "- GetImageScene: " + set.image_scene.to_s
puts "- GetImageTicksPerSecond: " + set.image_ticks_per_second.to_s
puts "- GetNumberImages: " + set.n_images.to_s
puts
# enum functions
puts "- GetImageCompression: " + set.image_compression.to_s
puts "- GetImageType: " + set.image_type.to_s
puts
