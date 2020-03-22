module Pixie
  class Pixel
    COLOR_HEX_REGEX = /^#([A-Fa-f0-9]{9}|[A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$/

    def initialize(@pixel_wand : LibMagick::PixelWand*)
    end

    def initialize
      @pixel_wand = LibMagick.newPixelWand
    end

    def self.parse(string : String)
      wand = new
      LibMagick.pixelSetColor(wand, string)
      wand
    end

    def self.from_hex(color : String)
      wand = new
      raise "Invalid hex code #{color}" unless color.match(COLOR_HEX_REGEX)
      self.parse(color)
    end

    def self.from_rgb(red : Int, green : Int, blue : Int, alpha : Int = 1)
      self.parse("rgba(#{red}, #{green}, #{blue}, #{alpha})")
    end

    def self.from_cmyk(cyan : Int, magenta : Int, yellow : Int, key : Int)
      self.parse("cmyk(#{cyan}, #{magenta}, #{yellow}, #{key})")
    end

    def alpha
      LibMagick.pixelGetAlpha(self)
    end

    def alpha_quantum
      LibMagick.pixelGetAlphaQuantum(self)
    end

    def alpha=(val : Float)
      LibMagick.pixelSetAlpha(self, val)
    end

    def alpha_quantum=(val : Float)
      LibMagick.pixelSetAlphaQuantum(self, val)
    end

    def black
      LibMagick.pixelGetBlack(self)
    end

    def black_quantum
      LibMagickpixelGetBlackQuantum(self)
    end

    def black=(val : Float)
      LibMagick.pixelSetBlack(self, val)
    end

    def black_quantum=(val : Float)
      LibMagick.pixelSetBlackQuantum(self, val)
    end

    def blue
      LibMagick.pixelGetBlue(self)
    end

    def blue_quantum
      LibMagickpixelGetBlueQuantum(self)
    end

    def blue=(val : Float)
      LibMagick.pixelSetBlue(self, val)
    end

    def blue_quantum=(val : Float)
      LibMagick.pixelSetBlueQuantum(self, val)
    end

    def cyan
      LibMagick.pixelGetCyan(self)
    end

    def cyan_quantum
      LibMagickpixelGetCyanQuantum(self)
    end

    def cyan=(val : Float)
      LibMagick.pixelSetCyan(self, val)
    end

    def cyan_quantum=(val : Float)
      LibMagick.pixelSetCyanQuantum(self, val)
    end

    def green
      LibMagick.pixelGetGreen(self)
    end

    def green_quantum
      LibMagickpixelGetGreenQuantum(self)
    end

    def green=(val : Float)
      LibMagick.pixelSetGreen(self, val)
    end

    def green_quantum=(val : Float)
      LibMagick.pixelSetGreenQuantum(self, val)
    end

    def magenta
      LibMagick.pixelGetMagenta(self)
    end

    def magenta_quantum
      LibMagickpixelGetMagentaQuantum(self)
    end

    def magenta=(val : Float)
      LibMagick.pixelSetMagenta(self, val)
    end

    def magenta_quantum=(val : Float)
      LibMagick.pixelSetMagentaQuantum(self, val)
    end

    def red
      LibMagick.pixelGetRed(self)
    end

    def red_quantum
      LibMagickpixelGetRedQuantum(self)
    end

    def red=(val : Float)
      LibMagick.pixelSetRed(self, val)
    end

    def red_quantum=(val : Float)
      LibMagick.pixelSetRedQuantum(self, val)
    end

    def yellow
      LibMagick.pixelGetYellow(self)
    end

    def yellow_quantum
      LibMagickpixelGetYellowQuantum(self)
    end

    def yellow=(val : Float)
      LibMagick.pixelSetYellow(self, val)
    end

    def yellow_quantum=(val : Float)
      LibMagick.pixelSetYellowQuantum(self, val)
    end

    def fuzz
      LibMagick.pixelGetFuzz(self)
    end

    def fuzz=(val : Float)
      LibMagick.pixelSetFuzz(self, val)
    end

    def hsl
      LibMagick.pixelGetHSL(self, out h, out s, out l)
      {hue: h, saturation: s, lightness: l}
    end

    def set_color(color : String)
      LibMagick.pixelSetColor(self, color)
    end

    def set_hsl(hue : Int, saturation : Int, lightness : Int)
      LibMagick.pixelSetHSL(self, hue, saturation, lightness)
    end

    def set_cmyk(cyan : Int, magenta : Int, yellow : Int, key : Int)
      func = "cmyk(#{cyan}, #{magenta}, #{yellow}, #{key})"
      self.set_color(func)
    end

    def set_rgb(red : Int, green : Int, blue : Int, alpha : Int? = nil)
      func = alpha ?
        "rgba(#{red}, #{green}, #{blue}, #{alpha})" :
        "rgb(#{red}, #{green}, #{blue})"
      self.set_color(func)
    end

    def index
      LibMagick.pixelGetIndex(self)
    end

    def quantum_packet
      LibMagick.pixelGetQuantumPacket(self, out packet)
      packet
    end

    def quantum_pixel(image : Image)
      LibMagick.pixelGetQuantumPixel(image, self, out pixel)
      pixel
    end

    def normalized_string
      String.new(LibMagick.pixelGetColorAsNormalizedString(self))
    end

    def to_s
      String.new(LibMagick.pixelGetColorAsString(self))
    end

    def size
      LibMagick.pixelGetColorCount(self)
    end

    def similar?(other : Pixel, fuzz : Float)
      LibMagick.isPixelWandSimilar(self, other, fuzz)
    end

    def clear
      LibMagick.clearPixelWand
    end

    def clone
      wand = LibMagick.clonePixelWand(self)
      new(wand)
    end

    def to_unsafe
      @pixel_wand
    end

    macro finalize
      LibMagick.destroyPixelWand(self)
    end
  end
end
