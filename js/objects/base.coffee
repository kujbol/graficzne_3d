objects = []

class window.BaseObject
  constructor: (@name) ->
    @points = []
    @triangles = []
    @settings = new BaseObjectSettings(@)
    @settings.load_settings()

  apply_settings: () ->
    """
      Returns new points for object, then you can import them to object
      and create triangles from this new Points
    """
    matrix = this.create_matrix()
    return (
      this.create_new_point(point, matrix) for point in @points
    )

  create_matrix: () ->
    output = math.eye(4)
    translation_set = @settings.position
    translation_matrix = translation(translation_set.x, translation_set.y, translation_set.z)
    output = math.multiply(translation_matrix, output)
    scale_setting = @settings.scale
    scale_matrix = scale(scale_setting.x, scale_setting.y, scale_setting.z)
    output = math.multiply(scale_matrix, output)
    rotate_matrix = this.create_rotate_matrix()
    return math.multiply(output, rotate_matrix)

  create_rotate_matrix: () ->
    rotate_settings = @settings.rotate
    rotate_matrix = math.eye(4)
    rotate_x_matrix = rotate_x(rotate_settings.x)
    rotate_matrix = math.multiply(rotate_matrix, rotate_x_matrix)
    rotate_y_matrix = rotate_y(rotate_settings.y)
    rotate_matrix = math.multiply(rotate_matrix, rotate_y_matrix)
    rotate_z_matrix = rotate_z(rotate_settings.z)
    return math.multiply(rotate_matrix, rotate_z_matrix)

  create_new_point: (point, matrix) ->
    matrix_point = create_matrix_point(point)
    matrix_point = math.multiply(matrix, matrix_point)
    [x, y, z] = unpack_matrix_point(matrix_point)
    return new Point(x, y, z)



class window.Point
  constructor: (@x, @y, @z) ->

  is_same: (point) ->
    point.x == @x and point.y == @y and point.z == @z

class window.Triangle
  constructor: (@p1, @p2, @p3) ->

  is_same: (triangle) ->
    triangle.p1 == @p1 and triangle.p2 == @p2 and triangle.p3 == @p3