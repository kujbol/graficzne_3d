class window.PerspectiveCamera
  constructor: (width, height, near, far) ->
    fx = 1 / width
    fy = 1 / height
    fz = - 2 / (far - near)
    tz = -(far + near)/(far - near)
    @matrix = math.matrix(
      [
        [fx, 0, 0, 0],
        [0, fy, 0, 0],
        [0, 0, fz, tz],
        [0, 0, 0, 1]
      ]
    )
    @matrix = math.multiply(@matrix, math.inv(translation(0,0,0)))

  cast_triangle: (triangle) ->
    p1 = math.multiply(@matrix, create_matrix_point(triangle.p1))
    p1 = new Point(p1._data[0][0], p1._data[1][0], 0)
    p2 = math.multiply(@matrix, create_matrix_point(triangle.p2))
    p2 = new Point(p2._data[0][0], p2._data[1][0], 0)
    p3 = math.multiply(@matrix, create_matrix_point(triangle.p3))
    p3 = new Point(p3._data[0][0], p3._data[1][0], 0)
    return new Triangle(p1, p2, p3)
