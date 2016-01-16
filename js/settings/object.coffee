class window.BaseObjectSettings extends BaseSettings
  constructor:(@object) ->
    super(@object)
    @colorful = new CheckBoxSettings('colorful', false)
    @filled = new CheckBoxSettings('filed', true)
    @position = new ThreeBoxSettings('position' ,0, 0, 0)
    @scale = new ThreeBoxSettings('scale', 1, 1, 1)
    @rotate = new ThreeBoxSettings('rotate', 0, 0, 0)

    @settings =  [@colorful, @filled, @position, @scale, @rotate]
    @panel = $('#settings_panel')
