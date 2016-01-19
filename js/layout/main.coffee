"""
  Function for front, using for menu
"""

window.add_object = (Object) ->
  object = new Object()
  scene.add_object(object)


window.show_camera_settings =  ->
  $('#wrapper').toggleClass 'toggled'