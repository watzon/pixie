require "file_utils"

module Helpers
  def self.image_path(type = :default)
    if type != :jpg_without_extension
      File.join("spec/fixtures",
        case type
        when :default, :jpg       then "default.jpg"
        when :png                 then "engine.png"
        when :animation, :gif     then "animation.gif"
        when :exif                then "exif.jpg"
        when :no_exif             then "no_exif.jpg"
        when :empty_identify_line then "empty_identify_line.png"
        when :badly_encoded_line  then "badly_encoded_line.jpg"
        when :not                 then "not_an_image.rb"
        when :colon               then "with:colon.jpg"
        when :clipping_path       then "clipping_path.jpg"
        when :get_pixels          then "get_pixels.png"
        when :rgb                 then "rgb.png"
        when :rgb_tmp             then "rgb_tmp.png"
        when :non_ascii_filename  then "スクリーンショット 2019-07-13 1.32.01.png"
        when :large_webp          then "large_webp.webp"
        else
          fail "image #{type.inspect} doesn't exist"
        end
      )
    else
      path = self.random_path
      FileUtils.cp(image_path, path)
      path
    end
  end

  def self.random_path(basename = "")
    File.tempname(prefix: basename)
  end
end