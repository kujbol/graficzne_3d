window.create_matrix_point = (point) ->
  return math.matrix([
    [point.x],
    [point.y],
    [point.z],
    [1]
  ])

window.unpack_matrix_point = (matrix_point) ->
  return [matrix_point._data[0][0], matrix_point._data[1][0], matrix_point._data[2][0]]

window.translation = (x, y, z) ->
  return math.matrix([
    [1, 0, 0, x],
    [0, 1, 0, y],
    [0, 0, 1, z],
    [0, 0, 0, 1]
  ])


window.scale = (x, y, z) ->
  return math.matrix([
    [x, 0, 0, 0],
    [0, y, 0, 0],
    [0, 0, z, 0],
    [0, 0, 0, 1]
  ])


window.rotate_x = (fi) ->
  return math.matrix([
    [1,     0,            0,         0],
    [0, math.cos(fi), -1*math.sin(fi), 0],
    [0, math.sin(fi),  math.cos(fi), 0],
    [0,     0,            0,         1]
  ])


window.rotate_y = (fi) ->
  return math.matrix([
    [math.cos(fi),  0, math.sin(fi), 0],
    [     0,        1,       0,      0],
    [-1*math.sin(fi), 0, math.cos(fi), 0],
    [     0,        0,       0,      1],
  ])


window.rotate_z = (fi) ->
  return math.matrix([
    [math.cos(fi), -1*math.sin(fi), 0,  0],
    [math.sin(fi),  math.cos(fi), 0,  0],
    [     0,            0,        1,  0],
    [     0,            0,        0,  1],
  ])


window.normalize_vector = (matrix) ->
  length = 0
  for row in matrix._data
    length += row[0] * row[0]

  for row in matrix._data
    row[0] = row[0]/length

