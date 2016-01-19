class window.PerspectiveCamera extends BaseObject
  constructor: () ->
    @settings = new CameraSettings(@)
    @settings.load_settings()

    far = 10
    near = 1
    FOVx = math.pi/2
    FOVy = math.pi/2

    fx = 1/math.tan(FOVx/2)
    fy = 1/math.tan(FOVy/2)
    fz = -(far + near)/(far - near)
    tz = - 2 * (far * near) / (far - near)


    @camera_matrix = math.matrix(
      [
        [fx, 0, 0, 0],
        [0, fy, 0, 0],
        [0, 0, fz, tz],
        [0, 0, -1, 0]
      ]
    )
    @update_matrix()

  update_matrix: () ->
    @matrix = @create_matrix()
    @matrix = math.inv(@matrix)
    @matrix = math.multiply(@camera_matrix, @matrix)

  apply_settings: () ->
    """
      Overwrite method of applaing settings, to stick with camera
      idea
    """
    @update_matrix()


  cast_triangle: (triangle) ->
    p1 = math.multiply(@matrix, create_matrix_point(triangle.p1))
    color = triangle.p1.color
    p1 = new Point(p1._data[0][0]/p1._data[3][0], p1._data[1][0]/p1._data[3][0], p1._data[2][0]/p1._data[3][0], color)
    p2 = math.multiply(@matrix, create_matrix_point(triangle.p2))
    color = triangle.p2.color
    p2 = new Point(p2._data[0][0]/p2._data[3][0], p2._data[1][0]/p2._data[3][0], p2._data[2][0]/p2._data[3][0], color)
    p3 = math.multiply(@matrix, create_matrix_point(triangle.p3))
    color = triangle.p3.color
    p3 = new Point(p3._data[0][0]/p3._data[3][0], p3._data[1][0]/p3._data[3][0], p3._data[2][0]/p3._data[3][0], color)

    return new Triangle(p1, p2, p3, color=triangle.color)
