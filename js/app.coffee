canvas = null

jQuery(document).ready ->
  canvas = document.getElementById('my_canvas')
  cl = new Cube()
  cl.settings.load_settings()
  ctx=canvas.getContext("2d")
  ctx.fillStyle="#FF0000"
  ctx.fillRect(20,20,150,100)
