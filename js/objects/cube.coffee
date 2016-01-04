class window.Cube extends BaseObject
  constructor: (points = null) ->
    super()

    if points is null
      for i in [1,-1]
        for j in [1, -1]
          for k in [1, -1]
            @points.push(new Point(k, j, i))
    else
      @points = points

    @create_triangles()

  create_triangles: () ->
    p = @points

    [p0, p1, p2, p3, p4, p5, p6, p7, p8] = [p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]]

    @triangles = [
      # front
      new Triangle(p0, p1, p2), new Triangle(p3, p1, p2),
      # behind
      new Triangle(p4, p6, p5), new Triangle(p7, p6, p5),
      # up
      new Triangle(p4, p0, p5), new Triangle(p1, p0, p5),
      # down
      new Triangle(p6, p2, p7), new Triangle(p3, p2, p7),
      # right
      new Triangle(p0, p4, p2), new Triangle(p6, p2, p4),
      # left
      new Triangle(p1, p5, p3), new Triangle(p7, p5, p3)
    ]