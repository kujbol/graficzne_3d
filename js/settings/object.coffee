class window.BaseObjectSettings extends BaseSettings
  constructor:(@object) ->
    super(@object)
    @panel = $('#settings_panel')

    @colorful = new CheckBoxSettings(@object, @panel, 'colorful', false)
    @filled = new CheckBoxSettings(@object, @panel,'filed', false)
    @position = new ThreeBoxSettings(@object, @panel, 'position' ,0, 0, 0)
    @scale = new ThreeBoxSettings(@object, @panel, 'scale', 1, 1, 1)
    @rotate = new ThreeBoxSettings(@object,@panel, 'rotate', 0, 0, 0)

    @settings =  [@colorful, @filled, @scale, @rotate, @position]

