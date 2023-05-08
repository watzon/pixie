lib LibMagick
  enum AlignType
    Undefined
    Left
    Center
    Right
  end

  enum AlphaChannelOption
    Undefined
    Activate
    Associate
    Background
    Copy
    Deactivate
    Discrete
    Disassociate
    Extract
    Off
    On
    Opaque
    Remove
    Set
    Shape
    Transparent
  end

  enum AlphaChannelType
    Undefined
    Activate
    Background
    Copy
    Deactivate
    Extract
    Opaque
    Reset # deprecated
    Set
    Shape
    Transparent
    Flatten
    Remove
    Associate
    Disassociate
  end

  enum AutoThresholdMethod
    Undefined
    Kapur
    OTSU
    Triangle
  end

  enum ChannelType
    Undefined            =    0x0000
    Red                  =    0x0001
    Gray                 =    0x0001
    Cyan                 =    0x0001
    Green                =    0x0002
    Magenta              =    0x0002
    Blue                 =    0x0004
    Yellow               =    0x0004
    Black                =    0x0008
    Alpha                =    0x0010
    Opacity              =    0x0010
    Index                =    0x0020 # Color Index Table?
    ReadMask             =    0x0040 # Pixel is Not Readable?
    WriteMask            =    0x0080 # Pixel is Write Protected?
    Meta                 =    0x0100 # not used
    CompositeMaskChannel =    0x0200 # SVG mask
    CompositeChannels    =    0x001F
    AllChannels          = 0x7ffffff
    # Special purpose channel types.
    # FUTURE: are these needed any more - they are more like hacks
    # SyncChannels for example is NOT a real channel but a 'flag'
    # It really says -- "User has not defined channels"
    # Though it does have extra meaning in the "-auto-level" operator
    TrueAlpha        =  0x0100 # extract actual alpha channel from opacity
    RGBChannels      =  0x0200 # set alpha from grayscale mask in RGB
    GrayChannels     =  0x0400
    SyncChannels     = 0x20000 # channels modified as a single unit
    DefaultChannels  = AllChannels
  end

  enum ClassType
    Undefined
    Direct
    Pseudo
  end

  enum ClipPathUnits
    UndefinedPathUnits
    UserSpace
    UserSpaceOnUse
    ObjectBoundingBox
  end

  enum ColorspaceType
    Undefined
    RGB  # Linear RGB colorspace
    GRAY # greyscale (linear) image (faked 1 channel)
    Transparent
    OHTA
    Lab
    XYZ
    YCbCr
    YCC
    YIQ
    YPbPr
    YUV
    CMYK # negared linear RGB with black separated
    SRGB # Default: non-lienar sRGB colorspace
    HSB
    HSL
    HWB
    Rec601Luma
    Rec601YCbCr
    Rec709Luma
    Rec709YCbCr
    Log
    CMY # negated linear RGB colorspace
    Luv
    HCL
    LCH # alias for LCHuv
    LMS
    LCHab # Cylindrical (Polar) Lab
    LCHuv # Cylindrical (Polar) Luv
    ScRGB
    HSI
    HSV # alias for HSB
    HCLp
    YDbDr
  end

  enum CommandOption
    MagickUndefined      = -1
    MagickAlign          =  0
    MagickAlphaChannel
    MagickBoolean
    MagickCache
    MagickChannel
    MagickClass
    MagickClipPath
    MagickCoder
    MagickColor
    MagickColorspace
    MagickCommand
    MagickComplex
    MagickCompliance
    MagickCompose
    MagickCompress
    MagickConfigure
    MagickDataType
    MagickDebug
    MagickDecorate
    MagickDelegate
    MagickDirection
    MagickDispose
    MagickDistort
    MagickDither
    MagickEndian
    MagickEvaluate
    MagickFillRule
    MagickFilter
    MagickFont
    MagickFonts
    MagickFormat
    MagickFunction
    MagickGradient
    MagickGravity
    MagickIntensity
    MagickIntent
    MagickInterlace
    MagickInterpolate
    MagickKernel
    MagickLayer
    MagickLineCap
    MagickLineJoin
    MagickList
    MagickLocale
    MagickLogEvent
    MagickLog
    MagickMagic
    MagickMethod
    MagickMetric
    MagickMime
    MagickMode
    MagickModule
    MagickMorphology
    MagickNoise
    MagickOrientation
    MagickPixelChannel
    MagickPixelIntensity
    MagickPixelMask
    MagickPixelTrait
    MagickPolicy
    MagickPolicyDomain
    MagickPolicyRights
    MagickPreview
    MagickPrimitive
    MagickQuantumFormat
    MagickResolution
    MagickResource
    MagickSparseColor
    MagickStatistic
    MagickStorage
    MagickStretch
    MagickStyle
    MagickThreshold
    MagickType
    MagickValidate
    MagickVirtualPixel
    MagickWeight
    MagickAutoThreshold
    MagickTool
    MagickCLI
  end

  enum ComplexOperator
    Undefined
    Add
    Conjugate
    Divide
    MagnitudePhase
    Multiply
    RealImaginary
    Subtract
  end

  enum ComplianceType
    Undefined
    None      =     0x0000
    CSS       =     0x0001
    SVG       =     0x0001
    X11       =     0x0002
    XPM       =     0x0004
    MVG       =     0x0008
    All       = 0x7fffffff
  end

  enum CompositeOperator
    Undefined
    Alpha
    Atop
    Blend
    Blur
    Bumpmap
    ChangeMask
    Clear
    ColorBurn
    ColorDodge
    Colorize
    CopyBlack
    CopyBlue
    Copy
    CopyCyan
    CopyGreen
    CopyMagenta
    CopyAlpha
    CopyRed
    CopyYellow
    Darken
    DarkenIntensity
    Difference
    Displace
    Dissolve
    Distort
    DivideDst
    DivideSrc
    DstAtop
    Dst
    DstIn
    DstOut
    DstOver
    Exclusion
    HardLight
    HardMix
    Hue
    In
    Intensity
    Lighten
    LightenIntensity
    LinearBurn
    LinearDodge
    LinearLight
    Luminize
    Mathematics
    MinusDst
    MinusSrc
    Modulate
    ModulusAdd
    ModulusSubtract
    Multiply
    No
    Out
    Over
    Overlay
    PegtopLight
    PinLight
    Plus
    Replace
    Saturate
    Screen
    SoftLight
    SrcAtop
    Src
    SrcIn
    SrcOut
    SrcOver
    Threshold
    VividLight
    Xor
    Stereo
  end

  enum CompressionType
    Undefined
    B44A
    B44
    BZip
    DXT1
    DXT3
    DXT5
    Fax
    Group4
    JBIG1
    JBIG2
    JPEG2000
    JPEG
    LosslessJPEG
    LZMA
    LZW
    No
    Piz
    Pxr24
    RLE
    Zip
    ZipS
    Zstd
    WebP
    DWAA
    DWAB
  end

  enum DecorationType
    Undefined
    None
    Underline
    Overline
    LineThrough
  end

  enum DirectionType
    Undefined
    RightToLeft
    LeftToRight
  end

  enum DisposeType
    Unrecognized
    Undefined    = 0
    None         = 1
    Background   = 2
    Previous     = 3
  end

  enum DistortImageMethod
    Undefined
    Affine
    AffineProjection
    ScaleRotateTranslate
    Perspective
    PerspectiveProjection
    BilinearForward
    Bilinear              = BilinearForward
    BilinearReverse
    Polynomial
    Arc
    Polar
    DePolar
    Cylinder2Plane
    Plane2Cylinder
    Barrel
    BarrelInverse
    Shepards
    Resize
    Sentinel
  end

  enum DistortMethod
    Undefined
    Affine
    AffineProjection
    ScaleRotateTranslate
    Perspective
    PerspectiveProjection
    BilinearForward
    Bilinear              = BilinearForward
    BilinearReverse
    Polynomial
    Arc
    Polar
    DePolar
    Cylinder2Plane
    Plane2Cylinder
    Barrel
    BarrelInverse
    Shepards
    Resize
    Sentinel
  end

  enum DitherMethod
    Undefined
    None
    Riemersma
    FloydSteinberg
  end

  enum EndianType
    Undefined
    LSB
    MSB
  end

  enum ExceptionType
    UndefinedException
    WarningException          = 300
    ResourceLimitWarning      = 300
    TypeWarning               = 305
    OptionWarning             = 310
    DelegateWarning           = 315
    MissingDelegateWarning    = 320
    CorruptImageWarning       = 325
    FileOpenWarning           = 330
    BlobWarning               = 335
    StreamWarning             = 340
    CacheWarning              = 345
    CoderWarning              = 350
    FilterWarning             = 352
    ModuleWarning             = 355
    DrawWarning               = 360
    ImageWarning              = 365
    WandWarning               = 370
    RandomWarning             = 375
    XServerWarning            = 380
    MonitorWarning            = 385
    RegistryWarning           = 390
    ConfigureWarning          = 395
    PolicyWarning             = 399
    ErrorException            = 400
    ResourceLimitError        = 400
    TypeError                 = 405
    OptionError               = 410
    DelegateError             = 415
    MissingDelegateError      = 420
    CorruptImageError         = 425
    FileOpenError             = 430
    BlobError                 = 435
    StreamError               = 440
    CacheError                = 445
    CoderError                = 450
    FilterError               = 452
    ModuleError               = 455
    DrawError                 = 460
    ImageError                = 465
    WandError                 = 470
    RandomError               = 475
    XServerError              = 480
    MonitorError              = 485
    RegistryError             = 490
    ConfigureError            = 495
    PolicyError               = 499
    FatalErrorException       = 700
    ResourceLimitFatalError   = 700
    TypeFatalError            = 705
    OptionFatalError          = 710
    DelegateFatalError        = 715
    MissingDelegateFatalError = 720
    CorruptImageFatalError    = 725
    FileOpenFatalError        = 730
    BlobFatalError            = 735
    StreamFatalError          = 740
    CacheFatalError           = 745
    CoderFatalError           = 750
    FilterFatalError          = 752
    ModuleFatalError          = 755
    DrawFatalError            = 760
    ImageFatalError           = 765
    WandFatalError            = 770
    RandomFatalError          = 775
    XServerFatalError         = 780
    MonitorFatalError         = 785
    RegistryFatalError        = 790
    ConfigureFatalError       = 795
    PolicyFatalError          = 799
  end

  enum FillRule
    UndefinedRule
    # undef EvenOddRule
    EvenOddRule
    NonZeroRule
  end

  enum FilterType
    Undefined
    Point
    Box
    Triangle
    Hermite
    Hann
    Hamming
    Blackman
    Gaussian
    Quadratic
    Cubic
    Catrom
    Mitchell
    Jinc
    Sinc
    SincFast
    Kaiser
    Welch
    Parzen
    Bohman
    Bartlett
    Lagrange
    Lanczos
    LanczosSharp
    Lanczos2
    Lanczos2Sharp
    Robidoux
    RobidouxSharp
    Cosine
    Spline
    LanczosRadius
    CubicSpline
    Sentinel # a count of all the filters, not a real filter
  end

  enum FilterTypes
    Undefined
    Point
    Box
    Triangle
    Hermite
    Hanning
    Hamming
    Blackman
    Gaussian
    Quadratic
    Cubic
    Catrom
    Mitchell
    Jinc
    Sinc
    SincFast
    Kaiser
    Welsh
    Parzen
    Bohman
    Bartlett
    Lagrange
    Lanczos
    LanczosSharp
    Lanczos2
    Lanczos2Sharp
    Robidoux
    RobidouxSharp
    Cosine
    Spline
    LanczosRadius
    Sentinel # a count of all the filters, not a real filter
  end

  enum GeometryFlags
    No                 =     0x0000
    X                  =     0x0001
    Xi                 =     0x0001
    Y                  =     0x0002
    Psi                =     0x0002
    Width              =     0x0004
    Rho                =     0x0004
    Height             =     0x0008
    Sigma              =     0x0008
    Chi                =     0x0010
    XiNegative              =     0x0020
    XNegative               =     0x0020
    PsiNegative             =     0x0040
    YNegative               =     0x0040
    ChiNegative             =     0x0080
    Percent            =     0x1000 # '%'  percentage of something
    Aspect             =     0x2000 # '!'  resize no-aspect - special use flag
    Normalize          =     0x2000 # '!'  ScaleKernel() in morphology.c
    Less               =     0x4000 # '<'  resize smaller - special use flag
    Greater            =     0x8000 # '>'  resize larger - spacial use flag
    Minimum            =    0x10000 # '^'  special handling needed
    CorrelateNormalize =    0x10000 # '^' see ScaleKernel()
    Area               =    0x20000 # '@'  resize to area - special use flag
    Decimal            =    0x40000 # '.'  floating point numbers found
    Separator          =    0x80000 # 'x'  separator found
    AllValues               = 0x7fffffff
  end

  enum GradientType
    Undefined
    Linear
    Radial
  end

  enum GravityType
    Undefined
    Forget    =  0
    NorthWest =  1
    North     =  2
    NorthEast =  3
    West      =  4
    Center    =  5
    East      =  6
    SouthWest =  7
    South     =  8
    SouthEast =  9
    Static    = 10
  end

  enum ImageLayerMethod
    Undefined
    Coalesce
    CompareAny
    CompareClear
    CompareOverlay
    Dispose
    Optimize
    OptimizeImage
    OptimizePlus
    OptimizeTrans
    RemoveDups
    RemoveZero
    Composite
    Merge
    Flatten
    Mosaic
    TrimBounds
  end

  enum ImageType
    Undefined
    Bilevel
    Grayscale
    GrayscaleMatte
    Palette
    PaletteMatte
    TrueColor
    TrueColorMatte
    ColorSeparation
    ColorSeparationMatte
    Optimize
    PaletteBilevelMatte
  end

  enum InterlaceType
    Undefined
    None
    Line
    Plane
    Partition
    GIF
    JPEG
    PNG
  end

  enum InterpolatePixelMethod
    Undefined
    Average         # Average 4 nearest neighbours
    Bicubic         # Catmull-Rom interpolation
    Bilinear        # Triangular filter interpolation
    Filter          # Use resize filter - (very slow)
    Integer         # Integer (floor) interpolation
    Mesh            # Triangular mesh interpolation
    NearestNeighbor # Nearest neighbour only
    Spline          # Cubic Spline (blurred) interpolation
    Average9        # Average 9 nearest neighbours
    Average16       # Average 16 nearest neighbours
    Blend           # blend of nearest 1, 2 or 4 pixels
    Background      # just return background color
    Catrom          # Catmull-Rom interpolation
  end

  enum KernelInfoType
    Undefined
    Unity
    Gaussian
    DoG
    LoG
    Blur
    Comet
    Binomial
    Laplacian
    Sobel
    FreiChen
    Roberts
    Prewitt
    Compass
    Kirsch
    Diamond
    Square
    Rectangle
    Octagon
    Disk
    Plus
    Cross
    Ring
    Peaks
    Edges
    Corners
    Diagonals
    LineEnds
    LineJunctions
    Ridges
    ConvexHull
    ThinSE
    Skeleton
    Chebyshev
    Manhattan
    Octagonal
    Euclidean
    UserDefined
  end

  enum LayerMethod
    Undefined
    Coalesce
    CompareAny
    CompareClear
    CompareOverlay
    Dispose
    Optimize
    OptimizeImage
    OptimizePlus
    OptimizeTrans
    RemoveDups
    RemoveZero
    Composite
    Merge
    Flatten
    Mosaic
    TrimBounds
  end

  enum LineCap
    Undefined
    Butt
    Round
    Square
  end

  enum LineJoin
    Undefined
    Miter
    Round
    Bevel
  end

  enum MagickEvaluateOperator
    Undefined
    Abs
    Add
    AddModulus
    And
    Cosine
    Divide
    Exponential
    GaussianNoise
    ImpulseNoise
    LaplacianNoise
    LeftShift
    Log
    Max
    Mean
    Median
    Min
    MultiplicativeNoise
    Multiply
    Or
    PoissonNoise
    Pow
    RightShift
    RootMeanSquare
    Set
    Sine
    Subtract
    Sum
    ThresholdBlack
    Threshold
    ThresholdWhite
    UniformNoise
    Xor
  end

  enum MagickFormatType
    Undefined
    Implicit
    Explicit
  end

  enum MagickFunction
    Undefined
    Arcsin
    Arctan
    Polynomial
    Sinusoid
  end

  enum MetricType
    Undefined
    Absolute
    Fuzz
    MeanAbsolute
    MeanErrorPerPixel
    MeanSquared
    NormalizedCrossCorrelation
    PeakAbsolute
    PeakSignalToNoiseRatio
    PerceptualHash
    RootMeanSquared
    StructuralSimilarity
    StructuralDissimilarity
  end

  enum MontageMode
    Undefined
    Frame
    Unframe
    Concatenate
  end

  enum MorphologyMethod
    Undefined
    Convolve
    Correlate
    Erode
    Dilate
    ErodeIntensity
    DilateIntensity
    IterativeDistance
    Open
    Close
    OpenIntensity
    CloseIntensity
    Smooth
    EdgeIn
    EdgeOut
    Edge
    TopHat
    BottomHat
    HitAndMiss
    Thinning
    Thicken
    Distance
    Voronoi
  end

  enum NoiseType
    Undefined
    Uniform
    Gaussian
    MultiplicativeGaussian
    Impulse
    Laplacian
    Poisson
    Random
  end

  enum OrientationType
    Undefined
    TopLeft
    TopRight
    BottomRight
    BottomLeft
    LeftTop
    RightTop
    RightBottom
    LeftBottom
  end

  enum PaintMethod
    Undefined
    Point
    Replace
    Floodfill
    FillToBorder
    Reset
  end

  enum PathMode
    Default
    Absolute
    Relative
  end

  enum PathOperation
    PathDefault
    PathClose                        # Z|z (none)
    PathCurveTo                      # C|c (x1 y1 x2 y2 x y)+
    PathCurveToQuadraticBezier       # Q|q (x1 y1 x y)+
    PathCurveToQuadraticBezierSmooth # T|t (x y)+
    PathCurveToSmooth                # S|s (x2 y2 x y)+
    PathEllipticArc                  # A|a (rx ry x-axis-rotation large-arc-flag sweep-flag x y)+
    PathLineToHorizontal             # H|h x+
    PathLineTo                       # L|l (x y)+
    PathLineToVertical               # V|v y+
    PathMoveTo                       # M|m (x y)+
  end

  enum PixelIntensityMethod
    Undefined       = 0
    Average
    Brightness
    Lightness
    MS
    Rec601Luma
    Rec601Luminance
    Rec709Luma
    Rec709Luminance
    RMS
  end

  enum PixelInterpolateMethod
    Undefined
    Average    # Average 4 nearest neighbours
    Average9   # Average 9 nearest neighbours
    Average16  # Average 16 nearest neighbours
    Background # Just return background color
    Bilinear   # Triangular filter interpolation
    Blend      # blend of nearest 1, 2 or 4 pixels
    Catrom     # Catmull-Rom interpolation
    Integer    # Integer (floor) interpolation
    Mesh       # Triangular Mesh interpolation
    Nearest    # Nearest Neighbour Only
    Spline     # Cubic Spline (blurred) interpolation
  end

  enum PixelMask
    UndefinedPixel = 0x000000
    ReadPixel      = 0x000001
    WritePixel     = 0x000002
    CompositePixel = 0x000004
  end

  enum PixelTrait
    UndefinedPixel = 0x000000
    CopyPixel      = 0x000001
    UpdatePixel    = 0x000002
    BlendPixel     = 0x000004
  end

  enum PreviewType
    Undefined
    Rotate
    Shear
    Roll
    Hue
    Saturation
    Brightness
    Gamma
    Spiff
    Dull
    Grayscale
    Quantize
    Despeckle
    ReduceNoise
    AddNoise
    Sharpen
    Blur
    Threshold
    EdgeDetect
    Spread
    Solarize
    Shade
    Raise
    Segment
    Swirl
    Implode
    Wave
    OilPaint
    CharcoalDrawing
    JPEG
  end

  enum PrimitiveType
    Undefined
    Point
    Line
    Rectangle
    RoundRectangle
    Arc
    Ellipse
    Circle
    Polyline
    Polygon
    Bezier
    Color
    Matte
    Text
    Image
    Path
  end

  enum ReferenceType
    Undefined
    Gradient
  end

  enum RenderingIntent
    Undefined
    Saturation
    Perceptual
    Absolute
    Relative
  end

  enum ResolutionType
    Undefined
    PixelsPerInch
    PixelsPerCentimeter
  end

  enum ResourceType
    Undefined
    Area
    Disk
    File
    Map
    Memory
    Thread
    Time
    Throttle
    Width
    Height
  end

  enum SparseColorMethod
    Undefined   = DistortImageMethod::Undefined
    Barycentric = DistortImageMethod::Affine
    Bilinear    = DistortImageMethod::BilinearReverse
    Polynomial  = DistortImageMethod::Polynomial
    Shepards    = DistortImageMethod::Shepards
    # Methods unique to SparseColor()
    Voronoi     = DistortImageMethod::Sentinel
    Inverse
    Manhattan
  end

  enum SpreadMethod
    Undefined
    Pad
    Reflect
    Repeat
  end

  enum StatisticType
    Undefined
    Gradient
    Maximum
    Mean
    Median
    Minimum
    Mode
    Nonpeak
    RootMeanSquare
    StandardDeviation
  end

  enum StorageType
    Undefined
    Char
    Double
    Float
    Long
    LongLong
    Quantum
    Short
  end

  enum StretchType
    Undefined
    Normal
    UltraCondensed
    ExtraCondensed
    Condensed
    SemiCondensed
    SemiExpanded
    Expanded
    ExtraExpanded
    UltraExpanded
    Any
  end

  enum StyleType
    Undefined
    Normal
    Italic
    Oblique
    Any
    Bold
  end

  enum TimerState
    Undefined
    Stopped
    Running
  end

  enum VirtualPixelMethod
    Undefined
    Background
    Dither
    Edge
    Mirror
    Random
    Tile
    Transparent
    Mask
    Black
    Gray
    White
    HorizontalTile
    VerticalTile
    HorizontalTileEdge
    VerticalTileEdge
    CheckerTile
  end
end
