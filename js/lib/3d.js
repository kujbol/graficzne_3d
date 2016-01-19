// Generated by CoffeeScript 1.10.0
(function() {
  window.create_matrix_point = function(point) {
    return math.matrix([[point.x], [point.y], [point.z], [1]]);
  };

  window.unpack_matrix_point = function(matrix_point) {
    return [matrix_point._data[0][0], matrix_point._data[1][0], matrix_point._data[2][0]];
  };

  window.translation = function(x, y, z) {
    return math.matrix([[1, 0, 0, x], [0, 1, 0, y], [0, 0, 1, z], [0, 0, 0, 1]]);
  };

  window.scale = function(x, y, z) {
    return math.matrix([[x, 0, 0, 0], [0, y, 0, 0], [0, 0, z, 0], [0, 0, 0, 1]]);
  };

  window.rotate_x = function(fi) {
    return math.matrix([[1, 0, 0, 0], [0, math.cos(fi), -1 * math.sin(fi), 0], [0, math.sin(fi), math.cos(fi), 0], [0, 0, 0, 1]]);
  };

  window.rotate_y = function(fi) {
    return math.matrix([[math.cos(fi), 0, math.sin(fi), 0], [0, 1, 0, 0], [-1 * math.sin(fi), 0, math.cos(fi), 0], [0, 0, 0, 1]]);
  };

  window.rotate_z = function(fi) {
    return math.matrix([[math.cos(fi), -1 * math.sin(fi), 0, 0], [math.sin(fi), math.cos(fi), 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]]);
  };

  window.normalize_vector = function(matrix) {
    var i, j, len, len1, length, ref, ref1, results, row;
    length = 0;
    ref = matrix._data;
    for (i = 0, len = ref.length; i < len; i++) {
      row = ref[i];
      length += row[0] * row[0];
    }
    ref1 = matrix._data;
    results = [];
    for (j = 0, len1 = ref1.length; j < len1; j++) {
      row = ref1[j];
      results.push(row[0] = row[0] / length);
    }
    return results;
  };

}).call(this);

//# sourceMappingURL=3d.js.map
