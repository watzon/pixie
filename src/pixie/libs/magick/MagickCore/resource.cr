lib LibMagick
  fun acquireMagickResource = AcquireMagickResource(type : ResourceType, size : LibC::SizeT) : Bool
  fun getPathTemplate = GetPathTemplate(path : LibC::Char*) : Bool
  fun acquireUniqueFileResource = AcquireUniqueFileResource(path : LibC::Char*) : LibC::Int
  fun getMagickResource = GetMagickResource(type : ResourceType) : LibC::SizeT
  fun getMagickResourceLimit = GetMagickResourceLimit(type : ResourceType) : LibC::SizeT
  fun listMagickResourceInfo = ListMagickResourceInfo(file : LibStd::File*, magick_unused : ExceptionInfo*) : Bool
  fun relinquishMagickResource = RelinquishMagickResource(type : ResourceType, size : LibC::SizeT) : Void
  fun relinquishUniqueFileResource = RelinquishUniqueFileResource(path : LibC::Char*) : Bool
  fun setMagickResourceLimit = SetMagickResourceLimit(type : ResourceType, limit : LibC::SizeT) : Bool
end
