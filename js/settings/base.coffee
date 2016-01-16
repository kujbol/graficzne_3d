active_settings = null
active_object = null

change_settings = () ->
  if active_settings != null
    for setting in active_settings.settings
      setting.update_settings()
    points = active_object.apply_settings()
    active_object.create_triangles(points)
    window.scene.add_object(active_object)

class window.BaseSettings
  constructor:(@object) ->
    @settings = []
    @panel = $('#settings_panel')

  set_active: ->
    active_settings = @
    active_object = @object

  load_settings: ->
    @clean_settings()
    @set_active()
    for setting in @settings
      setting.load_settings()

  clean_settings: ->
    active_settings = null
    @panel.empty()


class window.BaseBoxSettings
  constructor: ->
    @panel = $('#settings_panel')


class window.EditBoxSettings extends BaseBoxSettings
  constructor: (@name, @text) ->
    super()

  load_settings: ->
    @panel.append("<p><label for='#{@name}'>#{@name}: <input type='text' value=#{@text} id='#{@name}'/></label></p>")
    @edit = document.getElementById(@name)
    @edit.onchange = change_settings

  update_settings: ->
    @text = parseFloat(@edit.value)


class window.CheckBoxSettings extends BaseBoxSettings
  constructor: (@name, @value) ->
    super()

  load_settings: ->
    if @value == true
      checked = 'checked="checked"'
    else
      checked = ''
    @panel.append("<p><label for='#{@name}'>#{@name}: <input type='checkbox' id='#{@name}' #{checked}/></label></p>")
    @edit = document.getElementById(@name)
    @edit.onchange = change_settings

  update_settings: ->
    @value = @edit.checked


class window.ThreeBoxSettings extends BaseBoxSettings
  constructor: (@name, @x, @y, @z) ->
    super()

  load_settings: ->
    @panel.append("<p><b>#{@name}</b><ul><li><label for='#{@name}x'>#{@name} x: <input type='text' value='#{@x}' id='#{@name}x'/></label></li><li><label for='#{@name}y'>#{@name} y: <input type='text' value='#{@y}' id='#{@name}y'/></label></li><li><label for='#{@name}z'>#{@name} z: <input type='text' value='#{@z}' id='#{@name}z'/></label></li></ul></p>")
    @editx = document.getElementById("#{@name}x")
    @editx.onchange = change_settings
    @edity = document.getElementById("#{@name}y")
    @edity.onchange = change_settings
    @editz = document.getElementById("#{@name}z")
    @editz.onchange = change_settings

  update_settings: ->
    @x = parseFloat(@editx.value)
    @y = parseFloat(@edity.value)
    @z = parseFloat(@editz.value)

