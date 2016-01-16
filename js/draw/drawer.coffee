class window.Drawer
  constructor: (@canvas, @camera) ->
    @ratio = @canvas.width/@canvas.height

  draw_object: (object) ->
    ctx = @canvas.getContext("2d");
    for triangle in object.triangles
      triangle = @camera.cast_triangle(triangle)
      this.draw_line(ctx, triangle.p1, triangle.p2)
      this.draw_line(ctx, triangle.p2, triangle.p3)
      this.draw_line(ctx, triangle.p3, triangle.p1)


  draw_line: (ctx, p1, p2) ->
    ctx.beginPath()
    ctx.lineWidth = 10
    ctx.moveTo(this.to_screen_metrix(p1).x, this.to_screen_metrix(p1).y)
    ctx.lineTo(this.to_screen_metrix(p2).x, this.to_screen_metrix(p2).y)
    ctx.stroke()

  to_screen_metrix: (point) ->
    x = (point.x + 1.0)/2 * @canvas.width
    y = (point.y + 1.0)/2 * @canvas.height
    return new Point(x, y)