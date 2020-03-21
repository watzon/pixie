class File < IO::FileDescriptor

  getter mode : String

  private def initialize(@path, fd, @mode = "r", blocking = false, encoding = nil, invalid = nil)
    self.set_encoding(encoding, invalid: invalid) if encoding
    super(fd, blocking)
  end

  def self.new(filename : Path | String, mode = "r", perm = DEFAULT_CREATE_PERMISSIONS, encoding = nil, invalid = nil)
    filename = filename.to_s
    fd = Crystal::System::File.open(filename, mode, perm)
    new(filename, fd, mode, blocking: true, encoding: encoding, invalid: invalid)
  end

end
