window.save_file = () ->
  output = {}
  for object in window.scene.objects
    output[object.name] = {}
    for setting in object.settings.settings
      output[object.name][setting.name] = setting.values

  output['camera'] = {}
  for setting in window.scene.camera.settings.settings
    output['camera'][setting.name] = setting.values

  output = JSON.stringify(output)
  blob = new Blob([output], {type: "application/json"});
  url  = URL.createObjectURL(blob);

  a = document.getElementById("save_button")
  a.download    = "saved_scene.json";
  a.href        = url;

window.load_file = () ->
  document.getElementById('upload').addEventListener('change', handleFileSelect, false)
  $("#upload:hidden").trigger('click');

window.handleFileSelect = (evt) ->
  reader = new FileReader();
  reader.onload = onReaderLoad;
  reader.readAsText(event.target.files[0]);

window.onReaderLoad = (event) ->
  alert(JSON.parse(event.target.result));