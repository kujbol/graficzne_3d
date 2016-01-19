

class window.CameraSettings extends BaseSettings
  constructor:(@object) ->
    super(@object)

    @panel = $('#settings_camera')
    @camera_position = new ThreeBoxSettings(@object, @panel, 'camera_position' ,0, 0, 3)
    @camera_rotate = new ThreeBoxSettings(@object, @panel, 'camera_rotate', 0, 0, 0)
    @camera_near_z = new EditBoxSettings(@object, @panel, 'camera_near_z', -2)
    @camera_far_z = new EditBoxSettings(@object, @panel, 'camera_far_z', 2)

    @settings =  [@camera_rotate, @camera_position, @camera_far_z, @camera_near_z]
