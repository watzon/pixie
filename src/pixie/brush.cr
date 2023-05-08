module Pixie
  # The `Brush` class wraps `LibMagick::DrawingWand` and provides a simple
  # interface for drawing on an image.
  class Brush
    include Helpers

    def initialize(@wand : LibMagick::DrawingWand*)
    end

    def self.new
      wand = LibMagick.newDrawingWand
      new(wand)
    end

    def self.new(image : LibMagick::Image*, draw_info : LibMagick::DrawInfo*)
      wand = LibMagick.acquireDrawingWand(image, draw_info)
    end

    def self.new(image : Image, &block : LibMagick::DrawInfo ->)
      draw_info = LibMagick.acquireDrawInfo
      yield draw_info.value
      wand = LibMagick.acquireDrawingWand(image, draw_info)
      new(wand)
    end

    def self.new(image : Image, draw_info : LibMagick::DrawInfo)
      wand = LibMagick.acquireDrawingWand(image, pointerof(draw_info))
      new(wand)
    end

    def clear
      LibMagick.clearDrawingWand(@wand)
    end

    def clone
      new(LibMagick.cloneDrawingWand(@wand))
    end

    def affine(sx : Float64, sy : Float64, rx : Float64, ry : Float64, tx : Float64, ty : Float64)
      LibMagick.drawGetAffineMatrix(out matrix)
      LibMagick.drawAffine(@wand, pointerof(matrix))
    end

    def alpha(x : Int32, y : Int32, paint_method : LibMagick::PaintMethod = :point)
      LibMagick.drawAlpha(@wand, x, y, paint_method)
    end

    def annotation(x : Int32, y : Int32, text : String)
      LibMagick.drawAnnotation(@wand, x, y, text)
    end

    def arc(start_x : Float64, start_y : Float64, end_x : Float64, end_y : Float64, start_angle : Float64, end_angle : Float64)
      LibMagick.drawArc(@wand, start_x, start_y, end_x, end_y, start_angle, end_angle)
    end

    def bezier(coordinates : Array(Float64))
      LibMagick.drawBezier(@wand, coordinates.size, pointerof(coordinates))
    end

    def circle(origin_x : Float64, origin_y : Float64, perim_x : Float64, perim_y : Float64)
      LibMagick.drawCircle(@wand, origin_x, origin_y, perim_x, perim_y)
    end

    def color(x : Int32, y : Int32, paint_method : LibMagick::PaintMethod = :point)
      LibMagick.drawColor(@wand, x, y, paint_method)
    end

    def composite(compose : LibMagick::CompositeOperator, x : Int32, y : Int32, width : Int32, height : Int32, image : Image)
      LibMagick.drawComposite(@wand, compose, x, y, width, height, image)
    end

    def comment(comment : String)
      LibMagick.drawComment(@wand, comment)
    end

    def ellipse(origin_x : Float64, origin_y : Float64, radius_x : Float64, radius_y : Float64, start_angle : Float64, end_angle : Float64)
      LibMagick.drawEllipse(@wand, origin_x, origin_y, radius_x, radius_y, start_angle, end_angle)
    end

    def get_border_color
      LibMagick.drawGetBorderColor(@wand, out pixel)
      Pixel.new(pixel)
    end

    def get_clip_path
      path = LibMagick.drawGetClipPath(@wand)
      String.new(path)
    end

    def get_clip_rule
      LibMagick.drawGetClipRule(@wand)
    end

    def get_clip_units
      LibMagick.drawGetClipUnits(@wand)
    end

    def get_draw_density
      density = LibMagick.drawGetDrawDensity(@wand, out density)
      String.new(density)
    end

    def get_fill_color
      LibMagick.drawGetFillColor(@wand, out pixel)
      Pixel.new(pixel)
    end

    def get_fill_opacity
      LibMagick.drawGetFillOpacity(@wand)
    end

    def get_fill_rule
      LibMagick.drawGetFillRule(@wand)
    end

    def get_font
      font = LibMagick.drawGetFont(@wand)
      String.new(font)
    end

    def get_font_family
      family = LibMagick.drawGetFontFamily(@wand)
      String.new(family)
    end

    def get_font_resolution
      LibMagick.drawGetFontResolution(@wand, out x, out y)
      [x, y]
    end

    def get_font_size
      LibMagick.drawGetFontSize(@wand)
    end

    def get_font_stretch
      LibMagick.drawGetFontStretch(@wand)
    end

    def get_font_style
      LibMagick.drawGetFontStyle(@wand)
    end

    def get_font_weight
      LibMagick.drawGetFontWeight(@wand)
    end

    def get_gravity
      LibMagick.drawGetGravity(@wand)
    end

    def get_stroke_antialias
      LibMagick.drawGetStrokeAntialias(@wand)
    end

    def get_stroke_color
      LibMagick.drawGetStrokeColor(@wand, out pixel)
      Pixel.new(pixel)
    end

    def get_stroke_dash_array
      LibMagick.drawGetStrokeDashArray(@wand, out dash_array)
      Array.new(dash_array)
    end

    def get_stroke_dash_offset
      LibMagick.drawGetStrokeDashOffset(@wand)
    end

    def get_stroke_line_cap
      LibMagick.drawGetStrokeLineCap(@wand)
    end

    def get_stroke_line_join
      LibMagick.drawGetStrokeLineJoin(@wand)
    end

    def get_stroke_miter_limit
      LibMagick.drawGetStrokeMiterLimit(@wand)
    end

    def get_stroke_opacity
      LibMagick.drawGetStrokeOpacity(@wand)
    end

    def get_stroke_width
      LibMagick.drawGetStrokeWidth(@wand)
    end

    def get_text_alignment
      LibMagick.drawGetTextAlignment(@wand)
    end

    def get_text_antialias
      LibMagick.drawGetTextAntialias(@wand)
    end

    def get_text_decoration
      LibMagick.drawGetTextDecoration(@wand)
    end

    def get_text_direction
      LibMagick.drawGetTextDirection(@wand)
    end

    def get_text_encoding
      LibMagick.drawGetTextEncoding(@wand)
    end

    def get_text_interline_spacing
      LibMagick.drawGetTextInterlineSpacing(@wand)
    end

    def get_text_interword_spacing
      LibMagick.drawGetTextInterwordSpacing(@wand)
    end

    def get_text_kerning
      LibMagick.drawGetTextKerning(@wand)
    end

    def get_text_under_color
      LibMagick.drawGetTextUnderColor(@wand, out pixel)
      Pixel.new(pixel)
    end

    def get_vector_graphics
      str = LibMagick.drawGetVectorGraphics(@wand)
      String.new(str)
    end

    def line(start_x : Float64, start_y : Float64, end_x : Float64, end_y : Float64)
      LibMagick.drawLine(@wand, start_x, start_y, end_x, end_y)
    end

    def path_close
      LibMagick.drawPathClose(@wand)
    end

    def path_curve_to_absolute(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64, x : Float64, y : Float64)
      LibMagick.drawPathCurveToAbsolute(@wand, x1, y1, x2, y2, x, y)
    end

    def path_curve_to_relative(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64, x : Float64, y : Float64)
      LibMagick.drawPathCurveToRelative(@wand, x1, y1, x2, y2, x, y)
    end

    def path_curve_to_quadratic_bezier_absolute(x1 : Float64, y1 : Float64, x : Float64, y : Float64)
      LibMagick.drawPathCurveToQuadraticBezierAbsolute(@wand, x1, y1, x, y)
    end

    def path_curve_to_quadratic_bezier_relative(x1 : Float64, y1 : Float64, x : Float64, y : Float64)
      LibMagick.drawPathCurveToQuadraticBezierRelative(@wand, x1, y1, x, y)
    end

    def path_curve_to_quadratic_bezier_smooth_absolute(x : Float64, y : Float64)
      LibMagick.drawPathCurveToQuadraticBezierSmoothAbsolute(@wand, x, y)
    end

    def path_curve_to_quadratic_bezier_smooth_relative(x : Float64, y : Float64)
      LibMagick.drawPathCurveToQuadraticBezierSmoothRelative(@wand, x, y)
    end

    def path_curve_to_smooth_absolute(x2 : Float64, y2 : Float64, x : Float64, y : Float64)
      LibMagick.drawPathCurveToSmoothAbsolute(@wand, x2, y2, x, y)
    end

    def path_curve_to_smooth_relative(x2 : Float64, y2 : Float64, x : Float64, y : Float64)
      LibMagick.drawPathCurveToSmoothRelative(@wand, x2, y2, x, y)
    end

    def path_elliptic_arc_absolute(rx : Float64, ry : Float64, x_axis_rotation : Float64, large_arc_flag : Bool, sweep_flag : Bool, x : Float64, y : Float64)
      LibMagick.drawPathEllipticArcAbsolute(@wand, rx, ry, x_axis_rotation, large_arc_flag, sweep_flag, x, y)
    end

    def path_elliptic_arc_relative(rx : Float64, ry : Float64, x_axis_rotation : Float64, large_arc_flag : Bool, sweep_flag : Bool, x : Float64, y : Float64)
      LibMagick.drawPathEllipticArcRelative(@wand, rx, ry, x_axis_rotation, large_arc_flag, sweep_flag, x, y)
    end

    def path_finish
      LibMagick.drawPathFinish(@wand)
    end

    def path_line_to_absolute(x : Float64, y : Float64)
      LibMagick.drawPathLineToAbsolute(@wand, x, y)
    end

    def path_line_to_relative(x : Float64, y : Float64)
      LibMagick.drawPathLineToRelative(@wand, x, y)
    end

    def path_line_to_horizontal_absolute(x : Float64)
      LibMagick.drawPathLineToHorizontalAbsolute(@wand, x)
    end

    def path_line_to_horizontal_relative(x : Float64)
      LibMagick.drawPathLineToHorizontalRelative(@wand, x)
    end

    def path_line_to_vertical_absolute(y : Float64)
      LibMagick.drawPathLineToVerticalAbsolute(@wand, y)
    end

    def path_line_to_vertical_relative(y : Float64)
      LibMagick.drawPathLineToVerticalRelative(@wand, y)
    end

    def path_move_to_absolute(x : Float64, y : Float64)
      LibMagick.drawPathMoveToAbsolute(@wand, x, y)
    end

    def path_move_to_relative(x : Float64, y : Float64)
      LibMagick.drawPathMoveToRelative(@wand, x, y)
    end

    def path_start
      LibMagick.drawPathStart(@wand)
    end

    def point(x : Float64, y : Float64)
      LibMagick.drawPoint(@wand, x, y)
    end

    def polygon(number_coordinates : Int32, x : Float64, y : Float64)
      point = new_pointinfo(x, y)
      LibMagick.drawPolygon(@wand, number_coordinates, point)
    end

    def polyline(number_coordinates : Int32, x : Float64, y : Float64)
      point = new_pointinfo(x, y)
      LibMagick.drawPolyline(@wand, number_coordinates, point)
    end

    def pop_clip_path
      LibMagick.drawPopClipPath(@wand)
    end

    def pop_defs
      LibMagick.drawPopDefs(@wand)
    end

    def pop_pattern
      LibMagick.drawPopPattern(@wand)
    end

    def push_clip_path(id : String)
      LibMagick.drawPushClipPath(@wand, id)
    end

    def push_defs
      LibMagick.drawPushDefs(@wand)
    end

    def push_pattern(id : String, x : Float64, y : Float64, width : Float64, height : Float64)
      LibMagick.drawPushPattern(@wand, id, x, y, width, height)
    end

    def rectangle(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64)
      LibMagick.drawRectangle(@wand, x1, y1, x2, y2)
    end

    def render
      LibMagick.drawRender(@wand)
    end

    def reset_vector_graphics
      LibMagick.drawResetVectorGraphics(@wand)
    end

    def rotate(degrees : Float64)
      LibMagick.drawRotate(@wand, degrees)
    end

    def round_rectangle(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64, rx : Float64, ry : Float64)
      LibMagick.drawRoundRectangle(@wand, x1, y1, x2, y2, rx, ry)
    end

    def scale(x : Float64, y : Float64)
      LibMagick.drawScale(@wand, x, y)
    end

    def set_border_color(border_color : Pixel)
      LibMagick.drawSetBorderColor(@wand, border_color)
    end

    def set_clip_path(clip_mask_id : String)
      LibMagick.drawSetClipPath(@wand, clip_mask_id)
    end

    def set_clip_rule(fill_rule : FillRule)
      LibMagick.drawSetClipRule(@wand, fill_rule)
    end

    def set_clip_units(units : ClipPathUnits)
      LibMagick.drawSetClipUnits(@wand, units)
    end

    def set_density(density : String)
      LibMagick.drawSetDensity(@wand, density)
    end

    def set_fill_color(fill_color : Pixel)
      LibMagick.drawSetFillColor(@wand, fill_color)
    end

    def set_fill_opacity(fill_opacity : Float64)
      LibMagick.drawSetFillOpacity(@wand, fill_opacity)
    end

    def set_font_resolution(x : Float64, y : Float64)
      LibMagick.drawSetFontResolution(@wand, x, y)
    end

    def set_opacity(opacity : Float64)
      LibMagick.drawSetOpacity(@wand, opacity)
    end

    def set_fill_pattern_url(fill_url : String)
      LibMagick.drawSetFillPatternURL(@wand, fill_url)
    end

    def set_fill_rule(fill_rule : FillRule)
      LibMagick.drawSetFillRule(@wand, fill_rule)
    end

    def set_font(font : String)
      LibMagick.drawSetFont(@wand, font)
    end

    def set_font_family(font_family : String)
      LibMagick.drawSetFontFamily(@wand, font_family)
    end

    def set_font_size(pointsize : Float64)
      LibMagick.drawSetFontSize(@wand, pointsize)
    end

    def set_font_stretch(font_stretch : StretchType)
      LibMagick.drawSetFontStretch(@wand, font_stretch)
    end

    def set_font_style(font_style : StyleType)
      LibMagick.drawSetFontStyle(@wand, font_style)
    end

    def set_font_weight(font_weight : Int32)
      LibMagick.drawSetFontWeight(@wand, font_weight)
    end

    def set_gravity(gravity : GravityType)
      LibMagick.drawSetGravity(@wand, gravity)
    end

    def set_stroke_antialias(antialias : Bool)
      LibMagick.drawSetStrokeAntialias(@wand, antialias)
    end

    def set_stroke_color(stroke_color : Pixel)
      LibMagick.drawSetStrokeColor(@wand, stroke_color)
    end

    def set_stroke_dash_array(dash_array : Float64)
      LibMagick.drawSetStrokeDashArray(@wand, dash_array)
    end

    def set_stroke_dash_offset(dash_offset : Float64)
      LibMagick.drawSetStrokeDashOffset(@wand, dash_offset)
    end

    def set_stroke_line_cap(line_cap : LineCap)
      LibMagick.drawSetStrokeLineCap(@wand, line_cap)
    end

    def set_stroke_line_join(line_join : LineJoin)
      LibMagick.drawSetStrokeLineJoin(@wand, line_join)
    end

    def set_stroke_miter_limit(miterlimit : Int32)
      LibMagick.drawSetStrokeMiterLimit(@wand, miterlimit)
    end

    def set_stroke_opacity(stroke_opacity : Float64)
      LibMagick.drawSetStrokeOpacity(@wand, stroke_opacity)
    end

    def set_stroke_width(stroke_width : Float64)
      LibMagick.drawSetStrokeWidth(@wand, stroke_width)
    end

    def set_text_alignment(alignment : AlignType)
      LibMagick.drawSetTextAlignment(@wand, alignment)
    end

    def set_text_antialias(antialias : Bool)
      LibMagick.drawSetTextAntialias(@wand, antialias)
    end

    def set_text_decoration(decoration : DecorationType)
      LibMagick.drawSetTextDecoration(@wand, decoration)
    end

    def set_text_direction(direction : DirectionType)
      LibMagick.drawSetTextDirection(@wand, direction)
    end

    def set_text_encoding(encoding : String)
      LibMagick.drawSetTextEncoding(@wand, encoding)
    end

    def set_text_kerning(kerning : Float64)
      LibMagick.drawSetTextKerning(@wand, kerning)
    end

    def set_text_interline_spacing(spacing : Float64)
      LibMagick.drawSetTextInterlineSpacing(@wand, spacing)
    end

    def set_text_interword_spacing(spacing : Float64)
      LibMagick.drawSetTextInterwordSpacing(@wand, spacing)
    end

    def set_text_under_color(under_color : Pixel)
      LibMagick.drawSetTextUnderColor(@wand, under_color)
    end

    def set_vector_graphics(vector_graphics : String)
      LibMagick.drawSetVectorGraphics(@wand, vector_graphics)
    end

    def skew_x(degrees : Float64)
      LibMagick.drawSkewX(@wand, degrees)
    end

    def skew_y(degrees : Float64)
      LibMagick.drawSkewY(@wand, degrees)
    end

    def translate(x : Float64, y : Float64)
      LibMagick.drawTranslate(@wand, x, y)
    end

    def set_viewbox(x1 : Int32, y1 : Int32, x2 : Int32, y2 : Int32)
      LibMagick.drawSetViewbox(@wand, x1, y1, x2, y2)
    end

    def info
      ptr = LibMagick.peekDrawingWand(@wand)
      ptr.value
    end

    def pop
      LibMagick.popDrawingWand(@wand)
    end

    def push
      LibMagick.pushDrawingWand(@wand)
    end

    def finalize
      LibMagick.destroyDrawingWand(@wand)
    end

    def to_unsafe
      @wand
    end
  end
end
