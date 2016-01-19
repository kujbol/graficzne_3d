class window.Drawer
  constructor: (@canvas, @camera) ->
    @ctx = @canvas.getContext("2d")
    @zbuffor = (
      1000 for i in [0 ... 800] for j in [0 ... 800]
    )
    @canvas_array = @ctx.getImageData(0, 0, @canvas.width, @canvas.height)
    @actual_triangle = null

  _plot: (x, y, z, r, g, b) ->
    if @zbuffor[x][y] > z
      @zbuffor[x][y] = z
      @_set(x, y, r, g, b)

  _set: (x, y, r, g, b) ->
    @canvas_array.data[4*(x+y*@canvas.width)] = r
    @canvas_array.data[4*(x+y*@canvas.width)+1] = g
    @canvas_array.data[4*(x+y*@canvas.width)+2] = b
    @canvas_array.data[4*(x+y*@canvas.width)+3] = 255

  draw_objects: (objects) ->
    @ctx = @canvas.getContext("2d")
    @ctx.clearRect(0, 0, @canvas.width, @canvas.height)
    @canvas_array = @ctx.getImageData(0, 0, @canvas.width, @canvas.height)

    for object in objects
      console.log('rysuje')
      if object.settings.filled.value
        @draw_triangles(object)
      else
        @draw_lines(object)

    @ctx.putImageData(@canvas_array, 0, 0)

  draw_lines: (object) ->
    for triangle in object.triangles
      triangle = @camera.cast_triangle(triangle)
      p1 = @to_screen_metrix(triangle.p1)
      p2 = @to_screen_metrix(triangle.p2)
      p3 = @to_screen_metrix(triangle.p3)
      @_draw_line(p1, p2)
      @_draw_line(p2, p3)
      @_draw_line(p3, p1)

  draw_triangles: (object) ->
#    @ctx.beginPath()
#    @ctx.moveTo(200,100)
#    @ctx.lineTo(300,300)
#    @ctx.lineTo(100,200)
#    @ctx.fillStyle = '#FFFF00'
#    @ctx.closePath()
#    @ctx.fill();
#    @_draw_triangle(new Triangle(new Point(200,100),new Point(300,300),new Point(100,200)))
    for triangle in object.triangles
      triangle = @camera.cast_triangle(triangle)
      triangle = @triangle_to_screen(triangle)
      @actual_triangle = triangle
      @_draw_triangle(triangle)

  _draw_line: (p1, p2) ->
    @ctx.beginPath()
    @ctx.lineWidth = 1
    @ctx.moveTo(p1.x, p1.y)
    @ctx.lineTo(p2.x, p2.y)
    @ctx.stroke()

  __draw_line:(x1, y1, x2, y2) ->
#    @ctx.beginPath()
#    @ctx.lineWidth = 1
#    @ctx.moveTo(x1, y1)
#    @ctx.lineTo(x2, y2)
#    @ctx.stroke()

    if Math.abs(x2-x1)>= Math.abs(y2-y1)
      len = Math.abs(x2 - x1)
    else
      len = Math.abs(y2 -y1)

    dx = (x2 - x1) / len
    dy = (y2 - y1) / len

    x = x1 + 0.5 * ( (dx > 0) ? 1 : -1)
    y = y1 + 0.5 * ( (dy > 0) ? 1 : -1)
    for i in [0 .. len]
      @_plot(Math.round(x), Math.round(y),2,0,0,0)
      x = x + dx
      y = y + dy

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

  triangle_to_screen: (triangle) ->
    return new Triangle(
      @to_screen_metrix(triangle.p1),
      @to_screen_metrix(triangle.p2),
      @to_screen_metrix(triangle.p3),
    )

  to_screen_metrix: (point) ->
    x = Math.round((point.x + 1.0)/2 * @canvas.width)
    y = Math.round((point.y + 1.0)/2 * @canvas.height)
    z = point.z
    return new Point(x, y, z, point.color)