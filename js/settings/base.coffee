change_settings = (event) ->
  if event.data != null
    setting = event.data
    setting.update_settings()
    setting.object.apply_settings()
    scene.draw_scene()


class window.BaseSettings
  constructor:(@object) ->
    @settings = []
    @panel = $('#settings_panel')

  load_settings: ->
    @clean_settings()
    for setting in @settings
      setting.load_settings()

  clean_settings: ->
    @panel.empty()


class window.EditBoxSettings
  constructor: (@object, @panel, @name, @text) ->

  load_settings: ->
    @panel.append("<li><p><label for='#{@name}'>#{@name}: <input type='text' value=#{@text} id='#{@name}'/></label></p></li>")
    @edit = $("\##{@name}")
    @edit.change(this, change_settings)

  update_settings: ->
    @text = parseFloat(@edit.value)


class window.CheckBoxSettings
  constructor: (@object, @panel, @name, @value) ->

  load_settings: ->
    if @value == true
      checked = 'checked="checked"'
    else
      checked = ''
    @panel.append("<li><p><label for='#{@name}'>#{@name}: <input type='checkbox' id='#{@name}' #{checked}/></label></p></li>")
    @edit = $("\##{@name}")
    @edit.change(this, change_settings)

  update_settings: ->
    if @edit.is(":checked")
      @value = true
    else
      @value = false


class window.ThreeBoxSettings
  constructor: (@object, @panel, @name, @x, @y, @z) ->

  load_settings: ->
    @panel.append("<li><p><b>#{@name}</b><ul><li><label for='#{@name}x'>#{@name} x: <input type='text' value='#{@x}' id='#{@name}x'/></label></li><li><label for='#{@name}y'>#{@name} y: <input type='text' value='#{@y}' id='#{@name}y'/></label></li><li><label for='#{@name}z'>#{@name} z: <input type='text' value='#{@z}' id='#{@name}z'/></label></li></ul></p></li>")
    @editx = $("\##{@name}x")
    @editx.change(this, change_settings)
    @edity = $("\##{@name}y")
    @edity.change(this, change_settings)
    @editz = $("\##{@name}z")
    @editz.change(this, change_settings)
  update_settings: ->
    @x = parseFloat(@editx.val())
    @y = parseFloat(@edity.val())
    @z = parseFloat(@editz.val())

