canvas = null

window.onload = (e) ->
  canvas = document.getElementById('my_canvas')
  cl = new BaseObject
  alert('here')
  ctx=canvas.getContext("2d")
  ctx.fillStyle="#FF0000"
  ctx.fillRect(20,20,150,100)
