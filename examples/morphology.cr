# ---------------------------------------------------------------------------- #
# Example:     morphology
# Description: Morph of an image
# ---------------------------------------------------------------------------- #

require "../src/pixie"

set = Pixie::ImageSet.new("../spec/test2.png")
LibMagick.magickSetImageArtifact set, "convolve:bias", "50%"
gi = LibMagick::GeometryInfo.new
ei = LibMagick.acquireExceptionInfo
ki = LibMagick.acquireKernelBuiltIn LibMagick::KernelInfoType::SobelKernel, pointerof(gi), ei
LibMagick.magickMorphologyImage set, LibMagick::MorphologyMethod::ConvolveMorphology, 1, ki
LibMagick.magickWriteImage set, "output.jpg"
