# ---------------------------------------------------------------------------- #
# Example:     composite
# Author:      Mat
# Description: Add 2 image
# ---------------------------------------------------------------------------- #
require "../magickwand-crystal"

LibMagick.magickWandGenesis
wand1 = LibMagick.newMagickWand
wand2 = LibMagick.newMagickWand
LibMagick.magickReadImage wand1, "../spec/test2.jpg"
LibMagick.magickReadImage wand2, "../spec/test3.png"
LibMagick.magickCompositeImage wand1, wand2, LibMagick::CompositeOperator::OverCompositeOp, 50, 50
LibMagick.magickWriteImage wand1, "test.png"
LibMagick.destroyMagickWand( wand2 )
LibMagick.destroyMagickWand( wand1 )
LibMagick.magickWandTerminus
