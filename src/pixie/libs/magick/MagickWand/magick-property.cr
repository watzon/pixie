lib LibMagick
  fun magickDeleteImageArtifact = MagickDeleteImageArtifact(wand : MagickWand*, artifact : LibC::Char*) : Bool
  fun magickDeleteImageProperty = MagickDeleteImageProperty(wand : MagickWand*, property : LibC::Char*) : Bool
  fun magickDeleteOption = MagickDeleteOption(wand : MagickWand*, option : LibC::Char*) : Bool
  fun magickGetAntialias = MagickGetAntialias(wand : MagickWand*) : Bool
  fun magickGetBackgroundColor = MagickGetBackgroundColor(wand : MagickWand*) : PixelWand*
  fun magickGetColorspace = MagickGetColorspace(wand : MagickWand*) : ColorspaceType
  fun magickGetCompression = MagickGetCompression(wand : MagickWand*) : CompressionType
  fun magickGetCompressionQuality = MagickGetCompressionQuality(wand : MagickWand*) : LibC::SizeT
  fun magickGetCopyright = MagickGetCopyright : LibC::Char*
  fun magickGetFilename = MagickGetFilename(wand : MagickWand*) : LibC::Char*
  fun magickGetFont = MagickGetFont(wand : MagickWand*) : LibC::Char*
  fun magickGetFormat = MagickGetFormat(wand : MagickWand*) : LibC::Char*
  fun magickGetGravity = MagickGetGravity(wand : MagickWand*) : GravityType
  fun magickGetHomeURL = MagickGetHomeURL : LibC::Char*
  fun magickGetImageArtifact = MagickGetImageArtifact(wand : MagickWand*, artifact : LibC::Char*) : LibC::Char*
  fun magickGetImageArtifacts = MagickGetImageArtifacts(wand : MagickWand*, pattern : LibC::Char*, number_artifacts : LibC::SizeT*) : LibC::Char**
  fun magickGetImageProfile = MagickGetImageProfile(wand : MagickWand*, name : LibC::Char*, length : LibC::SizeT*) : LibC::UChar*
  fun magickGetImageProfiles = MagickGetImageProfiles(wand : MagickWand*, pattern : LibC::Char*, number_profiles : LibC::SizeT*) : LibC::Char**
  fun magickGetImageProperty = MagickGetImageProperty(wand : MagickWand*, property : LibC::Char*) : LibC::Char*
  fun magickGetImageProperties = MagickGetImageProperties(wand : MagickWand*, pattern : LibC::Char*, number_properties : LibC::SizeT*) : LibC::Char**
  fun magickGetInterlaceScheme = MagickGetInterlaceScheme(wand : MagickWand*) : InterlaceType
  fun magickGetInterpolateMethod = MagickGetInterpolateMethod(wand : MagickWand*) : PixelInterpolateMethod
  fun magickGetOption = MagickGetOption(wand : MagickWand*, key : LibC::Char*) : LibC::Char*
  fun magickGetOptions = MagickGetOptions(wand : MagickWand*, pattern : LibC::Char*, number_options : LibC::SizeT*) : LibC::Char**
  fun magickGetOrientation = MagickGetOrientation(wand : MagickWand*) : OrientationType
  fun magickGetPackageName = MagickGetPackageName : LibC::Char*
  fun magickGetPage = MagickGetPage(wand : MagickWand*, width : LibC::SizeT*, height : LibC::SizeT*, x : LibC::SSizeT*, y : LibC::SSizeT*) : Bool
  fun magickGetPointsize = MagickGetPointsize(wand : MagickWand*) : LibC::Double
  fun magickGetQuantumDepth = MagickGetQuantumDepth(depth : LibC::SizeT*) : LibC::Char*
  fun magickGetQuantumRange = MagickGetQuantumRange(range : LibC::SizeT*) : LibC::Char*
  fun magickGetReleaseDate = MagickGetReleaseDate : LibC::Char*
  fun magickGetResolution = MagickGetResolution(wand : MagickWand*, x : LibC::Double*, y : LibC::Double*) : Bool
  fun magickGetResource = MagickGetResource(type : ResourceType) : LibC::SizeT
  fun magickGetResourceLimit = MagickGetResourceLimit(type : ResourceType) : LibC::SizeT
  fun magickGetSamplingFactors = MagickGetSamplingFactors(wand : MagickWand*, number_factors : LibC::SizeT*) : LibC::Double*
  fun magickGetSize = MagickGetSize(wand : MagickWand*, columns : LibC::SizeT*, rows : LibC::SizeT*) : Bool
  fun magickGetSizeOffset = MagickGetSizeOffset(wand : MagickWand*, offset : LibC::SSizeT*) : Bool
  fun magickGetType = MagickGetType(wand : MagickWand*) : ImageType
  fun magickGetVersion = MagickGetVersion(version : LibC::SizeT*) : LibC::Char*
  fun magickProfileImage = MagickProfileImage(wand : MagickWand*, name : LibC::Char*, profile : Void*, length : LibC::SizeT) : Bool
  fun magickRemoveImageProfile = MagickRemoveImageProfile(wand : MagickWand*, name : LibC::Char*, length : LibC::SizeT*) : LibC::UChar*
  fun magickSetAntialias = MagickSetAntialias(wand : MagickWand*, antialias : Bool) : Bool
  fun magickSetBackgroundColor = MagickSetBackgroundColor(wand : MagickWand*, background : PixelWand*) : Bool
  fun magickSetColorspace = MagickSetColorspace(wand : MagickWand*, colorspace : ColorspaceType) : Bool
  fun magickSetCompression = MagickSetCompression(wand : MagickWand*, compression : CompressionType) : Bool
  fun magickSetCompressionQuality = MagickSetCompressionQuality(wand : MagickWand*, quality : LibC::SizeT) : Bool
  fun magickSetDepth = MagickSetDepth(wand : MagickWand*, depth : LibC::SizeT) : Bool
  fun magickSetExtract = MagickSetExtract(wand : MagickWand*, geometry : LibC::Char*) : Bool
  fun magickSetFilename = MagickSetFilename(wand : MagickWand*, filename : LibC::Char*) : Bool
  fun magickSetFont = MagickSetFont(wand : MagickWand*, font : LibC::Char*) : Bool
  fun magickSetFormat = MagickSetFormat(wand : MagickWand*, format : LibC::Char*) : Bool
  fun magickSetGravity = MagickSetGravity(wand : MagickWand*, type : GravityType) : Bool
  fun magickSetImageArtifact = MagickSetImageArtifact(wand : MagickWand*, artifact : LibC::Char*, value : LibC::Char*) : Bool
  fun magickSetImageProfile = MagickSetImageProfile(wand : MagickWand*, name : LibC::Char*, profile : Void*, length : LibC::SizeT) : Bool
  fun magickSetImageProperty = MagickSetImageProperty(wand : MagickWand*, property : LibC::Char*, value : LibC::Char*) : Bool
  fun magickSetInterlaceScheme = MagickSetInterlaceScheme(wand : MagickWand*, interlace_scheme : InterlaceType) : Bool
  fun magickSetInterpolateMethod = MagickSetInterpolateMethod(wand : MagickWand*, method : PixelInterpolateMethod) : Bool
  fun magickSetOption = MagickSetOption(wand : MagickWand*, key : LibC::Char*, value : LibC::Char*) : Bool
  fun magickSetOrientation = MagickSetOrientation(wand : MagickWand*, orientation : OrientationType) : Bool
  fun magickSetPage = MagickSetPage(wand : MagickWand*, width : LibC::SizeT, height : LibC::SizeT, x : LibC::SSizeT, y : LibC::SSizeT) : Bool
  fun magickSetPassphrase = MagickSetPassphrase(wand : MagickWand*, passphrase : LibC::Char*) : Bool
  fun magickSetPointsize = MagickSetPointsize(wand : MagickWand*, pointsize : LibC::Double) : Bool
  fun magickSetProgressMonitor = MagickSetProgressMonitor(wand : MagickWand*, progress_monitor : MagickProgressMonitor, client_data : Void*) : MagickProgressMonitor
  fun magickSetResourceLimit = MagickSetResourceLimit(type : ResourceType, limit : LibC::SizeT) : Bool
  fun magickSetResolution = MagickSetResolution(wand : MagickWand*, x_resolution : LibC::Double, y_resolution : LibC::Double) : Bool
  fun magickSetSamplingFactors = MagickSetSamplingFactors(wand : MagickWand*, number_factors : LibC::SizeT, sampling_factors : LibC::Double*) : Bool
  fun magickSetSeed = MagickSetSeed(seed : LibC::ULong) : Void
  fun magickSetSecurityPolicy = MagickSetSecurityPolicy(wand : MagickWand*, policy : LibC::Char*) : Bool
  fun magickSetSize = MagickSetSize(wand : MagickWand*, columns : LibC::SizeT, rows : LibC::SizeT) : Bool
  fun magickSetSizeOffset = MagickSetSizeOffset(wand : MagickWand*, columns : LibC::SizeT, rows : LibC::SizeT, offset : LibC::SSizeT) : Bool
  fun magickSetType = MagickSetType(wand : MagickWand*, image_type : ImageType) : Bool
end
