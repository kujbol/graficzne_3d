class window.Scene
  constructor: (@canvas) ->
    @objects = []
    @camera = new PerspectiveCamera(2,2,-2,2)
    @drawer = new Drawer(@canvas, @camera)

  add_object: (obj) ->
    @objects.push(obj)

  draw_scene: () ->
    ctx = @canvas.getContext("2d");
    ctx.clearRect(0, 0, @canvas.width, @canvas.height)
    for obj in @objects
      @drawer.draw_object(obj)

