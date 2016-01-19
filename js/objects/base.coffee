eps = 0.0001

objects = []
colors = [ '#6A9A1F', '#D43F3F', '#00ACE9', '#404040']

class window.BaseObject
  constructor: (@name) ->
    @points = []
    @triangles = []
    @settings = new BaseObjectSettings(@)
    @settings.load_settings()

  apply_settings: () ->
    """
      Method used after changing settings of an object, settings are updates
      and I'm only refreshing view
    """
    matrix = @create_matrix()
    points = @create_points()
    points =  (@create_new_point(point, matrix) for point in points)
    @create_triangles(points)


  create_matrix: (output=null) ->
    """
      Order of multiplying arrays is defined by order in settings array
      to change order you need to change order in this array
    """
    if output is null
      output = math.eye(4)
    for setting in @settings.settings
      if setting.name.indexOf('position') >= 0
        translation_matrix = translation(setting.x, setting.y, setting.z)
        output = math.multiply(translation_matrix, output)
      if setting.name.indexOf('scale') >= 0
        scale_matrix = scale(setting.x, setting.y, setting.z)
        output = math.multiply(scale_matrix, output)
      if setting.name.indexOf('rotate') >= 0
        rotate_matrix = this.create_rotate_matrix(setting, output)
        output = math.multiply(output, rotate_matrix)
    return output

  create_rotate_matrix: (setting, output) ->
    rotate_matrix = output
    rotate_x_matrix = rotate_x(setting.x)
    rotate_matrix = math.multiply(rotate_matrix, rotate_x_matrix)
    rotate_y_matrix = rotate_y(setting.y)
    rotate_matrix = math.multiply(rotate_matrix, rotate_y_matrix)
    rotate_z_matrix = rotate_z(setting.z)
    return math.multiply(rotate_matrix, rotate_z_matrix)

  create_new_point: (point, matrix) ->
    matrix_point = create_matrix_point(point)
    matrix_point = math.multiply(matrix, matrix_point)
    [x, y, z] = unpack_matrix_point(matrix_point)
    return new Point(x, y, z, point.color)

  create_triangles: () ->
    throw {name : "NotImplementedError", message : "should be overwritten"};

  create_points: () ->
    throw {name : "NotImplementedError", message : "should be overwritten"};

class window.Point
  constructor: (@x, @y, @z, color=null) ->
    if color
      @color = color
    else
      @color = @_rgbify(colors[Math.floor(Math.random() * colors.length)])

  is_same: (point) ->
    (
      math.abs(point.x-@x) < eps and
      math.abs(point.y-@y) < eps and
      math.abs(point.z-@z) < eps
    )

  _rgbify: (colr) ->
    colr = colr.replace /#/, ''
    if colr.length is 6
      [
        parseInt(colr.slice(0,2), 16)
        parseInt(colr.slice(2,4), 16)
        parseInt(colr.slice(4,6), 16)
      ]
    else
      [0, 0, 0]

class window.Triangle
  constructor: (@p1, @p2, @p3) ->

  is_same: (triangle) ->
    triangle.p1 == @p1 and triangle.p2 == @p2 and triangle.p3 == @p3