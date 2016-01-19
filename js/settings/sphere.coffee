class window.SphereSettings extends BaseObjectSettings
  constructor: (@object) ->
    super(@object)
    @panel = $('#settings_panel')

    @recursive = new EditBoxSettings(@object, @panel, 'recursive' , 1)

    @settings.push(@recursive)