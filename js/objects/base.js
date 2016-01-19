// Generated by CoffeeScript 1.10.0
(function() {
  var colors, eps, objects;

  eps = 0.0001;

  objects = [];

  colors = ['#6A9A1F', '#D43F3F', '#00ACE9', '#404040'];

  window.BaseObject = (function() {
    function BaseObject(name) {
      this.name = name;
      this.points = [];
      this.triangles = [];
      this.settings = new BaseObjectSettings(this);
      this.settings.load_settings();
    }

    BaseObject.prototype.apply_settings = function() {
      "Method used after changing settings of an object, settings are updates\nand I'm only refreshing view";
      var matrix, point, points;
      matrix = this.create_matrix();
      points = this.create_points();
      points = (function() {
        var i, len, results;
        results = [];
        for (i = 0, len = points.length; i < len; i++) {
          point = points[i];
          results.push(this.create_new_point(point, matrix));
        }
        return results;
      }).call(this);
      return this.create_triangles(points);
    };

    BaseObject.prototype.create_matrix = function(output) {
      var i, len, ref, rotate_matrix, scale_matrix, setting, translation_matrix;
      if (output == null) {
        output = null;
      }
      "Order of multiplying arrays is defined by order in settings array\nto change order you need to change order in this array";
      if (output === null) {
        output = math.eye(4);
      }
      ref = this.settings.settings;
      for (i = 0, len = ref.length; i < len; i++) {
        setting = ref[i];
        if (setting.name.indexOf('position') >= 0) {
          translation_matrix = translation(setting.x, setting.y, setting.z);
          output = math.multiply(translation_matrix, output);
        }
        if (setting.name.indexOf('scale') >= 0) {
          scale_matrix = scale(setting.x, setting.y, setting.z);
          output = math.multiply(scale_matrix, output);
        }
        if (setting.name.indexOf('rotate') >= 0) {
          rotate_matrix = this.create_rotate_matrix(setting, output);
          output = math.multiply(output, rotate_matrix);
        }
      }
      return output;
    };

    BaseObject.prototype.create_rotate_matrix = function(setting, output) {
      var rotate_matrix, rotate_x_matrix, rotate_y_matrix, rotate_z_matrix;
      rotate_matrix = output;
      rotate_x_matrix = rotate_x(setting.x);
      rotate_matrix = math.multiply(rotate_matrix, rotate_x_matrix);
      rotate_y_matrix = rotate_y(setting.y);
      rotate_matrix = math.multiply(rotate_matrix, rotate_y_matrix);
      rotate_z_matrix = rotate_z(setting.z);
      return math.multiply(rotate_matrix, rotate_z_matrix);
    };

    BaseObject.prototype.create_new_point = function(point, matrix) {
      var matrix_point, ref, x, y, z;
      matrix_point = create_matrix_point(point);
      matrix_point = math.multiply(matrix, matrix_point);
      ref = unpack_matrix_point(matrix_point), x = ref[0], y = ref[1], z = ref[2];
      return new Point(x, y, z, point.color);
    };

    BaseObject.prototype.create_triangles = function() {
      throw {
        name: "NotImplementedError",
        message: "should be overwritten"
      };
    };

    BaseObject.prototype.create_points = function() {
      throw {
        name: "NotImplementedError",
        message: "should be overwritten"
      };
    };

    return BaseObject;

  })();

  window.Point = (function() {
    function Point(x1, y1, z1, color) {
      this.x = x1;
      this.y = y1;
      this.z = z1;
      if (color == null) {
        color = null;
      }
      if (color) {
        this.color = color;
      } else {
        this.color = this._rgbify(colors[Math.floor(Math.random() * colors.length)]);
      }
    }

    Point.prototype.is_same = function(point) {
      return math.abs(point.x - this.x) < eps && math.abs(point.y - this.y) < eps && math.abs(point.z - this.z) < eps;
    };

    Point.prototype._rgbify = function(colr) {
      colr = colr.replace(/#/, '');
      if (colr.length === 6) {
        return [parseInt(colr.slice(0, 2), 16), parseInt(colr.slice(2, 4), 16), parseInt(colr.slice(4, 6), 16)];
      } else {
        return [0, 0, 0];
      }
    };

    return Point;

  })();

  window.Triangle = (function() {
    function Triangle(p1, p2, p3) {
      this.p1 = p1;
      this.p2 = p2;
      this.p3 = p3;
    }

    Triangle.prototype.is_same = function(triangle) {
      return triangle.p1 === this.p1 && triangle.p2 === this.p2 && triangle.p3 === this.p3;
    };

    return Triangle;

  })();

}).call(this);

//# sourceMappingURL=base.js.map
