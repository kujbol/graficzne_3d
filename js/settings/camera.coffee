

class window.CameraSettings extends BaseSettings
  constructor:(@object) ->
    super(@object)

    @panel = $('#settings_camera')
    @camera_position = new ThreeBoxSettings(@object, @panel, 'camera_position' ,0, -3, 5)
    @camera_rotate = new ThreeBoxSettings(@object, @panel, 'camera_rotate', 0.3, 0, 0)

    @settings =  [@camera_rotate, @camera_position]
