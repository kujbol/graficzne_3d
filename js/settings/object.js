// Generated by CoffeeScript 1.10.0
(function() {
  var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  window.BaseObjectSettings = (function(superClass) {
    extend(BaseObjectSettings, superClass);

    function BaseObjectSettings(object) {
      this.object = object;
      BaseObjectSettings.__super__.constructor.call(this, this.object);
      this.panel = $('#settings_panel');
      this.colorful = new CheckBoxSettings(this.object, this.panel, 'colorful', false);
      this.simple_color = new CheckBoxSettings(this.object, this.panel, 'simple_color', false);
      this.filled = new CheckBoxSettings(this.object, this.panel, 'filed', false);
      this.position = new ThreeBoxSettings(this.object, this.panel, 'position', 0, 0, 0);
      this.scale = new ThreeBoxSettings(this.object, this.panel, 'scale', 1, 1, 1);
      this.rotate = new ThreeBoxSettings(this.object, this.panel, 'rotate', 0, 0, 0);
      this.settings = [this.colorful, this.filled, this.simple_color, this.scale, this.rotate, this.position];
    }

    return BaseObjectSettings;

  })(BaseSettings);

}).call(this);

//# sourceMappingURL=object.js.map