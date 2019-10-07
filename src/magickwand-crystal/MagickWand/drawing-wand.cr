lib LibMagick
  fun acquireDrawingWand = AcquireDrawingWand(draw_info : DrawInfo*, image : Image*) : DrawingWand*
  fun clearDrawingWand = ClearDrawingWand(wand : DrawingWand*) : Void
  fun cloneDrawingWand = CloneDrawingWand(wand : DrawingWand*) : DrawingWand*
  fun destroyDrawingWand = DestroyDrawingWand(wand : DrawingWand*) : DrawingWand*
  fun drawAffine = DrawAffine(wand : DrawingWand*, affine : AffineMatrix*) : Void
  fun drawAlpha = DrawAlpha(wand : DrawingWand*, x : LibC::Double, y : LibC::Double, paint_method : PaintMethod) : Void
  fun drawAnnotation = DrawAnnotation(wand : DrawingWand*, x : LibC::Double, y : LibC::Double, text : LibC::UChar*) : Void
  fun drawArc = DrawArc(wand : DrawingWand*, sx : LibC::Double, sy : LibC::Double, ex : LibC::Double, ey : LibC::Double, sd : LibC::Double, ed : LibC::Double) : Void
  fun drawBezier = DrawBezier(wand : DrawingWand*, number_coordinates : LibC::SizeT, coordinates : PointInfo*) : Void
  fun drawCircle = DrawCircle(wand : DrawingWand*, ox : LibC::Double, oy : LibC::Double, px : LibC::Double, py : LibC::Double) : Void
  fun drawClearException = DrawClearException(wand : DrawingWand*) : Bool
  fun drawCloneExceptionInfo = DrawCloneExceptionInfo(wand : DrawingWand*) : ExceptionInfo*
  fun drawColor = DrawColor(wand : DrawingWand*, x : LibC::Double, y : LibC::Double, paint_method : PaintMethod) : Void
  fun drawComposite = DrawComposite(wand : DrawingWand*, compose : CompositeOperator, x : LibC::Double, y : LibC::Double, width : LibC::Double, height : LibC::Double, magick_wand : MagickWand*) : Bool
  fun drawComment = DrawComment(wand : DrawingWand*, comment : LibC::Char*) : Void
  fun drawEllipse = DrawEllipse(wand : DrawingWand*, ox : LibC::Double, oy : LibC::Double, rx : LibC::Double, ry : LibC::Double, start : LibC::Double, end : LibC::Double) : Void
  fun drawGetBorderColor = DrawGetBorderColor(wand : DrawingWand*, border_color : PixelWand*) : Void
  fun drawGetClipPath = DrawGetClipPath(wand : DrawingWand*) : LibC::Char*
  fun drawGetClipRule = DrawGetClipRule(wand : DrawingWand*) : FillRule
  fun drawGetClipUnits = DrawGetClipUnits(wand : DrawingWand*) : ClipPathUnits
  fun drawGetDensity = DrawGetDensity(wand : DrawingWand*) : LibC::Char*
  fun drawGetException = DrawGetException(wand : DrawingWand*, severity : ExceptionType*) : LibC::Char*
  fun drawGetExceptionType = DrawGetExceptionType(wand : DrawingWand*) : ExceptionType
  fun drawGetFillColor = DrawGetFillColor(wand : DrawingWand*, fill_color : PixelWand*) : Void
  fun drawGetFillOpacity = DrawGetFillOpacity(wand : DrawingWand*) : LibC::Double
  fun drawGetFillRule = DrawGetFillRule(wand : DrawingWand*) : FillRule
  fun drawGetFont = DrawGetFont(wand : DrawingWand*) : LibC::Char*
  fun drawGetFontFamily = DrawGetFontFamily(wand : DrawingWand*) : LibC::Char*
  fun drawGetFontResolution = DrawGetFontResolution(wand : DrawingWand*, x : LibC::Double*, y : LibC::Double*) : Bool
  fun drawGetFontSize = DrawGetFontSize(wand : DrawingWand*) : LibC::Double
  fun drawGetFontStretch = DrawGetFontStretch(wand : DrawingWand*) : StretchType
  fun drawGetFontStyle = DrawGetFontStyle(wand : DrawingWand*) : StyleType
  fun drawGetFontWeight = DrawGetFontWeight(wand : DrawingWand*) : LibC::SizeT
  fun drawGetGravity = DrawGetGravity(wand : DrawingWand*) : GravityType
  fun drawGetOpacity = DrawGetOpacity(wand : DrawingWand*) : LibC::Double
  fun drawGetStrokeAntialias = DrawGetStrokeAntialias(wand : DrawingWand*) : Bool
  fun drawGetStrokeColor = DrawGetStrokeColor(wand : DrawingWand*, stroke_color : PixelWand*) : Void
  fun drawGetStrokeDashArray = DrawGetStrokeDashArray(wand : DrawingWand*, number_elements : LibC::SizeT*) : LibC::Double*
  fun drawGetStrokeDashOffset = DrawGetStrokeDashOffset(wand : DrawingWand*) : LibC::Double
  fun drawGetStrokeLineCap = DrawGetStrokeLineCap(wand : DrawingWand*) : LineCap
  fun drawGetStrokeLineJoin = DrawGetStrokeLineJoin(wand : DrawingWand*) : LineJoin
  fun drawGetStrokeMiterLimit = DrawGetStrokeMiterLimit(wand : DrawingWand*) : LibC::SizeT
  fun drawGetStrokeOpacity = DrawGetStrokeOpacity(wand : DrawingWand*) : LibC::Double
  fun drawGetStrokeWidth = DrawGetStrokeWidth(wand : DrawingWand*) : LibC::Double
  fun drawGetTextAlignment = DrawGetTextAlignment(wand : DrawingWand*) : AlignType
  fun drawGetTextAntialias = DrawGetTextAntialias(wand : DrawingWand*) : Bool
  fun drawGetTextDecoration = DrawGetTextDecoration(wand : DrawingWand*) : DecorationType
  fun drawGetTextDirection = DrawGetTextDirection(wand : DrawingWand*) : DirectionType
  fun drawGetTextEncoding = DrawGetTextEncoding(wand : DrawingWand*) : LibC::Char*
  fun drawGetTextKerning = DrawGetTextKerning(wand : DrawingWand*) : LibC::Double
  fun drawGetTextInterlineSpacing = DrawGetTextInterlineSpacing(wand : DrawingWand*) : LibC::Double
  fun drawGetTextInterwordSpacing = DrawGetTextInterwordSpacing(wand : DrawingWand*) : LibC::Double
  fun drawGetTypeMetrics = DrawGetTypeMetrics(wand : DrawingWand*, text : LibC::Char*, ignore_newlines : Bool, metrics : TypeMetric*) : Bool
  fun drawGetVectorGraphics = DrawGetVectorGraphics(wand : DrawingWand*) : LibC::Char*
  fun drawGetTextUnderColor = DrawGetTextUnderColor(wand : DrawingWand*, under_color : PixelWand*) : Void
  fun drawLine = DrawLine(wand : DrawingWand*, sx : LibC::Double, sy : LibC::Double, ex : LibC::Double, ey : LibC::Double) : Void
  fun drawPathClose = DrawPathClose(wand : DrawingWand*) : Void
  fun drawPathCurveToAbsolute = DrawPathCurveToAbsolute(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x2 : LibC::Double, y2 : LibC::Double, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToRelative = DrawPathCurveToRelative(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x2 : LibC::Double, y2 : LibC::Double, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToQuadraticBezierAbsolute = DrawPathCurveToQuadraticBezierAbsolute(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToQuadraticBezierRelative = DrawPathCurveToQuadraticBezierRelative(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToQuadraticBezierSmoothAbsolute = DrawPathCurveToQuadraticBezierSmoothAbsolute(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToQuadraticBezierSmoothRelative = DrawPathCurveToQuadraticBezierSmoothRelative(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToSmoothAbsolute = DrawPathCurveToSmoothAbsolute(wand : DrawingWand*, x2 : LibC::Double, y2 : LibC::Double, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathCurveToSmoothRelative = DrawPathCurveToSmoothRelative(wand : DrawingWand*, x2 : LibC::Double, y2 : LibC::Double, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathEllipticArcAbsolute = DrawPathEllipticArcAbsolute(wand : DrawingWand*, rx : LibC::Double, ry : LibC::Double, x_axis_rotation : LibC::Double, large_arc_flag : Bool, sweep_flag : Bool, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathEllipticArcRelative = DrawPathEllipticArcRelative(wand : DrawingWand*, rx : LibC::Double, ry : LibC::Double, x_axis_rotation : LibC::Double, large_arc_flag : Bool, sweep_flag : Bool, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathFinish = DrawPathFinish(wand : DrawingWand*) : Void
  fun drawPathLineToAbsolute = DrawPathLineToAbsolute(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathLineToRelative = DrawPathLineToRelative(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathLineToHorizontalAbsolute = DrawPathLineToHorizontalAbsolute(wand : DrawingWand*, x : LibC::Double) : Void
  fun drawPathLineToHorizontalRelative = DrawPathLineToHorizontalRelative(wand : DrawingWand*, x : LibC::Double) : Void
  fun drawPathLineToVerticalAbsolute = DrawPathLineToVerticalAbsolute(wand : DrawingWand*, y : LibC::Double) : Void
  fun drawPathLineToVerticalRelative = DrawPathLineToVerticalRelative(wand : DrawingWand*, y : LibC::Double) : Void
  fun drawPathMoveToAbsolute = DrawPathMoveToAbsolute(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathMoveToRelative = DrawPathMoveToRelative(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPathStart = DrawPathStart(wand : DrawingWand*) : Void
  fun drawPoint = DrawPoint(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawPolygon = DrawPolygon(wand : DrawingWand*, number_coordinates : LibC::SizeT, coordinates : PointInfo*) : Void
  fun drawPolyline = DrawPolyline(wand : DrawingWand*, number_coordinates : LibC::SizeT, coordinates : PointInfo*) : Void
  fun drawPopClipPath = DrawPopClipPath(wand : DrawingWand*) : Void
  fun drawPopDefs = DrawPopDefs(wand : DrawingWand*) : Void
  fun drawPopPattern = DrawPopPattern(wand : DrawingWand*) : Bool
  fun drawPushClipPath = DrawPushClipPath(wand : DrawingWand*, clip_mask_id : LibC::Char*) : Void
  fun drawPushDefs = DrawPushDefs(wand : DrawingWand*) : Void
  fun drawPushPattern = DrawPushPattern(wand : DrawingWand*, pattern_id : LibC::Char*, x : LibC::Double, y : LibC::Double, width : LibC::Double, height : LibC::Double) : Bool
  fun drawRectangle = DrawRectangle(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x2 : LibC::Double, y2 : LibC::Double) : Void
  fun drawRender = DrawRender(wand : DrawingWand*) : Bool
  fun drawResetVectorGraphics = DrawResetVectorGraphics(wand : DrawingWand*) : Void
  fun drawRotate = DrawRotate(wand : DrawingWand*, degrees : LibC::Double) : Void
  fun drawRoundRectangle = DrawRoundRectangle(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x2 : LibC::Double, y2 : LibC::Double, rx : LibC::Double, ry : LibC::Double) : Void
  fun drawScale = DrawScale(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawSetBorderColor = DrawSetBorderColor(wand : DrawingWand*, border_wand : PixelWand*) : Void
  fun drawSetClipPath = DrawSetClipPath(wand : DrawingWand*, clip_mask : LibC::Char*) : Bool
  fun drawSetClipRule = DrawSetClipRule(wand : DrawingWand*, fill_rule : FillRule) : Void
  fun drawSetClipUnits = DrawSetClipUnits(wand : DrawingWand*, clip_units : ClipPathUnits) : Void
  fun drawSetDensity = DrawSetDensity(wand : DrawingWand*, density : LibC::Char*) : Bool
  fun drawSetFillColor = DrawSetFillColor(wand : DrawingWand*, fill_wand : PixelWand*) : Void
  fun drawSetFillOpacity = DrawSetFillOpacity(wand : DrawingWand*, fill_opacity : LibC::Double) : Void
  fun drawSetFontResolution = DrawSetFontResolution(wand : DrawingWand*, x_resolution : LibC::Double, y_resolution : LibC::Double) : Bool
  fun drawSetOpacity = DrawSetOpacity(wand : DrawingWand*, opacity : LibC::Double) : Void
  fun drawSetFillPatternURL = DrawSetFillPatternURL(wand : DrawingWand*, fill_url : LibC::Char*) : Bool
  fun drawSetFillRule = DrawSetFillRule(wand : DrawingWand*, fill_rule : FillRule) : Void
  fun drawSetFont = DrawSetFont(wand : DrawingWand*, font_name : LibC::Char*) : Bool
  fun drawSetFontFamily = DrawSetFontFamily(wand : DrawingWand*, font_family : LibC::Char*) : Bool
  fun drawSetFontSize = DrawSetFontSize(wand : DrawingWand*, pointsize : LibC::Double) : Void
  fun drawSetFontStretch = DrawSetFontStretch(wand : DrawingWand*, font_stretch : StretchType) : Void
  fun drawSetFontStyle = DrawSetFontStyle(wand : DrawingWand*, style : StyleType) : Void
  fun drawSetFontWeight = DrawSetFontWeight(wand : DrawingWand*, font_weight : LibC::SizeT) : Void
  fun drawSetGravity = DrawSetGravity(wand : DrawingWand*, gravity : GravityType) : Void
  fun drawSetStrokeColor = DrawSetStrokeColor(wand : DrawingWand*, stroke_wand : PixelWand*) : Void
  fun drawSetStrokePatternURL = DrawSetStrokePatternURL(wand : DrawingWand*, stroke_url : LibC::Char*) : Bool
  fun drawSetStrokeAntialias = DrawSetStrokeAntialias(wand : DrawingWand*, stroke_antialias : Bool) : Void
  fun drawSetStrokeDashArray = DrawSetStrokeDashArray(wand : DrawingWand*, number_elements : LibC::SizeT, dasharray : LibC::Double*) : Bool
  fun drawSetStrokeDashOffset = DrawSetStrokeDashOffset(wand : DrawingWand*, dash_offset : LibC::Double) : Void
  fun drawSetStrokeLineCap = DrawSetStrokeLineCap(wand : DrawingWand*, linecap : LineCap) : Void
  fun drawSetStrokeLineJoin = DrawSetStrokeLineJoin(wand : DrawingWand*, linejoin : LineJoin) : Void
  fun drawSetStrokeMiterLimit = DrawSetStrokeMiterLimit(wand : DrawingWand*, miterlimit : LibC::SizeT) : Void
  fun drawSetStrokeOpacity = DrawSetStrokeOpacity(wand : DrawingWand*, opacity : LibC::Double) : Void
  fun drawSetStrokeWidth = DrawSetStrokeWidth(wand : DrawingWand*, stroke_width : LibC::Double) : Void
  fun drawSetTextAlignment = DrawSetTextAlignment(wand : DrawingWand*, alignment : AlignType) : Void
  fun drawSetTextAntialias = DrawSetTextAntialias(wand : DrawingWand*, text_antialias : Bool) : Void
  fun drawSetTextDecoration = DrawSetTextDecoration(wand : DrawingWand*, decoration : DecorationType) : Void
  fun drawSetTextDirection = DrawSetTextDirection(wand : DrawingWand*, direction : DirectionType) : Void
  fun drawSetTextEncoding = DrawSetTextEncoding(wand : DrawingWand*, encoding : LibC::Char*) : Void
  fun drawSetTextKerning = DrawSetTextKerning(wand : DrawingWand*, kerning : LibC::Double) : Void
  fun drawSetTextInterlineSpacing = DrawSetTextInterlineSpacing(wand : DrawingWand*, interline_spacing : LibC::Double) : Void
  fun drawSetTextInterwordSpacing = DrawSetTextInterwordSpacing(wand : DrawingWand*, interword_spacing : LibC::Double) : Void
  fun drawSetTextUnderColor = DrawSetTextUnderColor(wand : DrawingWand*, under_wand : PixelWand*) : Void
  fun drawSetVectorGraphics = DrawSetVectorGraphics(wand : DrawingWand*, xml : LibC::Char*) : Bool
  fun drawSkewX = DrawSkewX(wand : DrawingWand*, degrees : LibC::Double) : Void
  fun drawSkewY = DrawSkewY(wand : DrawingWand*, degrees : LibC::Double) : Void
  fun drawTranslate = DrawTranslate(wand : DrawingWand*, x : LibC::Double, y : LibC::Double) : Void
  fun drawSetViewbox = DrawSetViewbox(wand : DrawingWand*, x1 : LibC::Double, y1 : LibC::Double, x2 : LibC::Double, y2 : LibC::Double) : Void
  fun isDrawingWand = IsDrawingWand(wand : DrawingWand*) : Bool
  fun newDrawingWand = NewDrawingWand : DrawingWand*
  fun peekDrawingWand = PeekDrawingWand(wand : DrawingWand*) : DrawInfo*
  fun popDrawingWand = PopDrawingWand(wand : DrawingWand*) : Bool
  fun pushDrawingWand = PushDrawingWand(wand : DrawingWand*) : Bool
end
