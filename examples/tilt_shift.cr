# ---------------------------------------------------------------------------- #
# Example:     tilt_shift
# Author:      watzon
# Description: Use sparse_color to create a tilt-shift effect
# ---------------------------------------------------------------------------- #

require "../src/pixie"

arglist = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, -1.0, 1.0, 1.0, 1.0]
funclist = [4.0, -4.0, 1.0]

img = Pixie::Image.new("spec/fixtures/engine.png")
arglist[6] = Float64.new(img.height - 1)

img.sigmoidal_constrast(15, LibMagick::QuantumRange * 0.4, sharpen: true)
comp = img.clone

comp.sparse_color(:barycentric, arglist)
comp.function(:polynomial, funclist)
if comp.set_artifact("compose:args", "15")
  img.composite(comp, :blur, false, 0, 0)
  img.write("output.jpg")
end


