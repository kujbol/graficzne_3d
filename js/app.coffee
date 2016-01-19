canvas = null
window.scene = null

jQuery(document).ready ->
  canvas = document.getElementById('my_canvas')
  window.scene = new Scene(canvas)
