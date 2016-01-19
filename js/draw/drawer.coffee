class window.Drawer
  constructor: (@canvas, @camera) ->
    @ctx = @canvas.getContext("2d")
    @zbuffor = (
      100000 for i in [0 .. @canvas.height] for j in [0 .. @canvas.width]
    )
    @canvas_array = @ctx.getImageData(0, 0, @canvas.width, @canvas.height)
    @actual_triangle = null
    @actual_object = null

  draw_objects: (objects) ->
    @ctx = @canvas.getContext("2d")
    @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
    @_clear_buffor()
    @canvas_array = @ctx.getImageData(0, 0, @canvas.width, @canvas.height)

    for object in objects
      @actual_object = object
      if object.settings.filled.value
        @draw_triangles(object)
      else
        @draw_lines(object)

    @ctx.putImageData(@canvas_array, 0, 0)

  draw_lines: (object) ->
    for triangle in object.triangles
      triangle = @camera.cast_triangle(triangle)
      @actual_triangle = triangle
      p1 = @to_screen_metrix(triangle.p1)
      p2 = @to_screen_metrix(triangle.p2)
      p3 = @to_screen_metrix(triangle.p3)
      @__draw_line(p1.x, p1.y, p2.x, p2.y, true)
      @__draw_line(p2.x, p2.y, p3.x, p3.y, true)
      @__draw_line(p3.x, p3.y, p1.x, p1.y, true)

  draw_triangles: (object) ->
    for triangle in object.triangles
      triangle = @camera.cast_triangle(triangle)
      triangle = @triangle_to_screen(triangle)
      @actual_triangle = triangle
      @_draw_triangle(triangle)

  __draw_line:(x1, y1, x2, y2) ->
    if Math.abs(x2-x1)>= Math.abs(y2-y1)
      len = Math.abs(x2-x1)
    else
      len = Math.abs(y2-y1)

    dx = (x2-x1)/len
    dy = (y2-y1)/len

    x=x1+0.5*((dx > 0) ? 1 : -1)
    y=y1+0.5*((dy > 0) ? 1 : -1)
    [z, r, g, b] = @_count_z_and_color(x, y)
    # edges of triagnles
    @_plot(Math.round(x), Math.round(y),z-5, 0, 0, 0)

    for i in [0 .. len]
      [z, r, g, b] = @_count_z_and_color(x, y)
      @_plot(Math.round(x), Math.round(y),z, r, g, b)
      x = x + dx
      y = y + dy

    #edges of triangles
    @_plot(Math.round(x-dx), Math.round(y-dy),z-5, 0, 0, 0)

  _draw_triangle: (triangle) ->
    points = [triangle.p1, triangle.p2, triangle.p3].sort (a, b) ->
    #  b.y - a.y
      a.y - b.y
    [p1, p2, p3] = points

    if p2.y == p3.y
      @_fill_bottom_flat_triangle(p1, p2 ,p3)
    else if p1.y == p2.y
      @_fill_top_flat_triangle(p1, p2, p3)
    else
      p4 = new Point(
       Math.round(p1.x + (p2.y - p1.y)/(p3.y - p1.y) * (p3.x - p1.x)),
        p2.y,
        (p2.y - p1.y)/(p3.y - p1.y) * (p3.z - p1.z)
      )
      @_fill_bottom_flat_triangle(p1, p2, p4)
      @_fill_top_flat_triangle(p2, p4, p3)


  _fill_bottom_flat_triangle: (p1, p2, p3) ->
    invslope1 = (p2.x - p1.x) / (p2.y - p1.y)
    invslope2 = (p3.x - p1.x) / (p3.y - p1.y)

    curx1 = p1.x
    curx2 = p1.x

    for scanlineY in [p1.y .. p2.y]
      @__draw_line(Math.round(curx1), scanlineY, Math.round(curx2), scanlineY)
      curx1 += invslope1
      curx2 += invslope2

  _fill_top_flat_triangle: (p1, p2, p3) ->
    invslope1 = (p3.x - p1.x) / (p3.y - p1.y)
    invslope2 = (p3.x - p2.x) / (p3.y - p2.y)

    curx1 = p3.x
    curx2 = p3.x

    for scanlineY in [p3.y .. p1.y]
      curx1 -= invslope1
      curx2 -= invslope2
      @__draw_line(Math.round(curx1), scanlineY, Math.round(curx2), scanlineY)

  _plot: (x, y, z, r, g, b) ->
    if 0 < x < @canvas.width and 0 < y < @canvas.height
      if @zbuffor[x][y] >= z
        @zbuffor[x][y] = z
        @_set(x, y, r, g, b)

  _set: (x, y, r, g, b) ->
    @canvas_array.data[4*(x+y*@canvas.width)] = r
    @canvas_array.data[4*(x+y*@canvas.width)+1] = g
    @canvas_array.data[4*(x+y*@canvas.width)+2] = b
    @canvas_array.data[4*(x+y*@canvas.width)+3] = 255

  _count_z_and_color: (x, y) ->
    [p1, p2, p3] = [@actual_triangle.p1, @actual_triangle.p2, @actual_triangle.p3]
    sum = @_are_of_triangle(p1, p2, p3.x, p3.y)
    p1_percent = @_are_of_triangle(p2, p3, x, y)
    p2_percent = @_are_of_triangle(p1, p3, x, y)
    p3_percent = @_are_of_triangle(p1, p2, x, y)

    z = (p1.z*p1_percent+p2.z*p2_percent+p3.z*p3_percent)/sum
    if @actual_object.settings.colorful.value and @actual_object.settings.simple_color.value is false and @actual_object.settings.filled.value
      [r1, g1, b1] = p1.color
      [r2, g2, b2] = p2.color
      [r3, g3, b3] = p3.color
      r = (r1*p1_percent+r2*p2_percent+r3*p3_percent)/sum
      g = (g1*p1_percent+g2*p2_percent+g3*p3_percent)/sum
      b = (b1*p1_percent+b2*p2_percent+b3*p3_percent)/sum
      return [z, r, g, b]
    else if @actual_object.settings.colorful.value and ( @actual_object.settings.simple_color.value or not @actual_object.settings.filled.value)
      return [z, p1.color[0], p1.color[1], p1.color[2]]
    else
      return [z, 0, 0, 0]

  _clear_buffor: ()->
    for a in [0 .. @canvas.width]
      for b in [0 .. @canvas.height]
        @zbuffor[a][b] = 100000

  _are_of_triangle: (p1, p2, x, y) ->
    return (1/2) * Math.abs((x-p1.x)*(y-p2.y)-(y-p1.y)*(x-p2.x))

  triangle_to_screen: (triangle) ->
    return new Triangle(
      @to_screen_metrix(triangle.p1),
      @to_screen_metrix(triangle.p2),
      @to_screen_metrix(triangle.p3),
    )

  to_screen_metrix: (point) ->
    x = Math.round((point.x + 1.0)/2 * @canvas.width)
    y = Math.round((point.y + 1.0)/2 * @canvas.height)
    z = Math.round((point.z + 1.0)/2 * @canvas.height)
    return new Point(x, y, z, point.color)