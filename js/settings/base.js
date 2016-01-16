// Generated by CoffeeScript 1.10.0
(function() {
  var active_object, active_settings, change_settings,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  active_settings = null;

  active_object = null;

  change_settings = function() {
    var i, len, points, ref, setting;
    if (active_settings !== null) {
      ref = active_settings.settings;
      for (i = 0, len = ref.length; i < len; i++) {
        setting = ref[i];
        setting.update_settings();
      }
      points = active_object.apply_settings();
      active_object.create_triangles(points);
      return window.scene.add_object(active_object);
    }
  };

  window.BaseSettings = (function() {
    function BaseSettings(object) {
      this.object = object;
      this.settings = [];
      this.panel = $('#settings_panel');
    }

    BaseSettings.prototype.set_active = function() {
      active_settings = this;
      return active_object = this.object;
    };

    BaseSettings.prototype.load_settings = function() {
      var i, len, ref, results, setting;
      this.clean_settings();
      this.set_active();
      ref = this.settings;
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        setting = ref[i];
        results.push(setting.load_settings());
      }
      return results;
    };

    BaseSettings.prototype.clean_settings = function() {
      active_settings = null;
      return this.panel.empty();
    };

    return BaseSettings;

  })();

  window.BaseBoxSettings = (function() {
    function BaseBoxSettings() {
      this.panel = $('#settings_panel');
    }

    return BaseBoxSettings;

  })();

  window.EditBoxSettings = (function(superClass) {
    extend(EditBoxSettings, superClass);

    function EditBoxSettings(name, text) {
      this.name = name;
      this.text = text;
      EditBoxSettings.__super__.constructor.call(this);
    }

    EditBoxSettings.prototype.load_settings = function() {
      this.panel.append("<p><label for='" + this.name + "'>" + this.name + ": <input type='text' value=" + this.text + " id='" + this.name + "'/></label></p>");
      this.edit = document.getElementById(this.name);
      return this.edit.onchange = change_settings;
    };

    EditBoxSettings.prototype.update_settings = function() {
      return this.text = parseFloat(this.edit.value);
    };

    return EditBoxSettings;

  })(BaseBoxSettings);

  window.CheckBoxSettings = (function(superClass) {
    extend(CheckBoxSettings, superClass);

    function CheckBoxSettings(name, value) {
      this.name = name;
      this.value = value;
      CheckBoxSettings.__super__.constructor.call(this);
    }

    CheckBoxSettings.prototype.load_settings = function() {
      var checked;
      if (this.value === true) {
        checked = 'checked="checked"';
      } else {
        checked = '';
      }
      this.panel.append("<p><label for='" + this.name + "'>" + this.name + ": <input type='checkbox' id='" + this.name + "' " + checked + "/></label></p>");
      this.edit = document.getElementById(this.name);
      return this.edit.onchange = change_settings;
    };

    CheckBoxSettings.prototype.update_settings = function() {
      return this.value = this.edit.checked;
    };

    return CheckBoxSettings;

  })(BaseBoxSettings);

  window.ThreeBoxSettings = (function(superClass) {
    extend(ThreeBoxSettings, superClass);

    function ThreeBoxSettings(name, x, y, z) {
      this.name = name;
      this.x = x;
      this.y = y;
      this.z = z;
      ThreeBoxSettings.__super__.constructor.call(this);
    }

    ThreeBoxSettings.prototype.load_settings = function() {
      this.panel.append("<p><b>" + this.name + "</b><ul><li><label for='" + this.name + "x'>" + this.name + " x: <input type='text' value='" + this.x + "' id='" + this.name + "x'/></label></li><li><label for='" + this.name + "y'>" + this.name + " y: <input type='text' value='" + this.y + "' id='" + this.name + "y'/></label></li><li><label for='" + this.name + "z'>" + this.name + " z: <input type='text' value='" + this.z + "' id='" + this.name + "z'/></label></li></ul></p>");
      this.editx = document.getElementById(this.name + "x");
      this.editx.onchange = change_settings;
      this.edity = document.getElementById(this.name + "y");
      this.edity.onchange = change_settings;
      this.editz = document.getElementById(this.name + "z");
      return this.editz.onchange = change_settings;
    };

    ThreeBoxSettings.prototype.update_settings = function() {
      this.x = parseFloat(this.editx.value);
      this.y = parseFloat(this.edity.value);
      return this.z = parseFloat(this.editz.value);
    };

    return ThreeBoxSettings;

  })(BaseBoxSettings);

}).call(this);

//# sourceMappingURL=base.js.map
