# ---------------------------------------------------------------------------- #
# Example:     morphology
# Author:      watzon
# Description: Use morphology to apply a kernel to an image
# ---------------------------------------------------------------------------- #

require "../src/pixie"

img = Pixie::Image.new("spec/fixtures/default.jpg")
gi = LibMagick::GeometryInfo.new
ei = LibMagick.acquireExceptionInfo
ki = LibMagick.acquireKernelBuiltIn LibMagick::KernelInfoType::Sobel, pointerof(gi), ei

img.set_artifact("convolve:bias", "50%")
img.morphology_method(:convolve, 1, ki)
img.write("output.jpg")
