module Pixie::Helpers
  private def new_pointinfo(x, y)
    point = LibMagick::PointInfo.new
    point.x = x
    point.y = y
    pointerof(point)
  end

  ##
  # Calculate the new width or height of an image, such that the aspect ratio
  # is preserved and the new width or height is less than or equal to the
  # specified maximum.
  #
  private def preserve_aspect_ratio(from_w, from_h, to_w, to_h)
    max_dimension = [to_w, to_h].max
    if from_w > from_h
      [max_dimension, (max_dimension * from_h / from_w).to_i]
    else
      [(max_dimension * from_w / from_h).to_i, max_dimension]
    end
  end

  private def ptr_to_string_array(ptr, count)
    output = Array(String).new(count)
    count.times do |i|
      output << String.new(ptr[i])
    end
    output
  end

  def self.assert_no_exception(exception_info : LibMagick::ExceptionInfo)
    if exception_info.severity != LibMagick::ExceptionType::UndefinedException
      raise "Failed to interpret image properties: #{exception_info.reason}"
    end
  end

  private def check_exception!
    exception = LibMagick.magickGetException(self, out exception_type)
    if exception_type.to_s.ends_with?("Error")
      raise String.new(exception)
    end
  end

  # enum StorageType
  #   Undefined
  #   Char
  #   Double
  #   Float
  #   Long
  #   LongLong
  #   Quantum
  #   Short
  # end

  private def depth_to_storage_type(depth : Int)
    case depth
    when 8
      LibMagick::StorageType::Char
    when 16
      LibMagick::StorageType::Short
    when 32
      LibMagick::StorageType::Long
    when 64
      LibMagick::StorageType::LongLong
    when 128
      LibMagick::StorageType::Double
    when 256
      LibMagick::StorageType::Quantum
    else
      raise "Unsupported depth: #{depth}, must be one of 8, 16, 32, 64, 128, 256"
    end
  end
end
