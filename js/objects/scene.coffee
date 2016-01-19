class window.Scene
  constructor: (@canvas) ->
    @objects = []
    @camera = new PerspectiveCamera()
    @drawer = new Drawer(@canvas, @camera)

  add_object: (obj) ->
    @objects.push(obj)
    @camera.settings.load_settings()
    window.create_list()
    @draw_scene()

  draw_scene: () ->
    @camera.update_matrix()
    @drawer.draw_objects(@objects)

