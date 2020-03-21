# ---------------------------------------------------------------------------- #
# Example:     floodfill
# Author:      Mat
# Description: Remove an image color
# ---------------------------------------------------------------------------- #

require "../src/pixie"

LibMagick.magickWandGenesis
m_wand = LibMagick.newMagickWand
fc_wand = LibMagick.newPixelWand
bc_wand = LibMagick.newPixelWand
if LibMagick.magickReadImage(m_wand, "../spec/test3.png")
  LibMagick.pixelSetColor fc_wand, "none"
  LibMagick.pixelSetColor bc_wand, "red"
  channel = LibMagick.parseChannelOption "rgba"
  LibMagick.magickFloodfillPaintImage m_wand, fc_wand, 20, bc_wand, 150, 150, false
  LibMagick.magickWriteImage m_wand, "output.png"
end
LibMagick.destroyPixelWand bc_wand
LibMagick.destroyPixelWand fc_wand
LibMagick.destroyMagickWand m_wand
LibMagick.magickWandTerminus
