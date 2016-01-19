window.create_list = () ->
  select = $("#object_list")
  select.empty()
  for object in window.scene.objects
    select.append($("<option>").attr('value',object.name).text(object.name));

  select.on(
    'change', () ->
      for object in window.scene.objects
        if object.name == this.value
          object.settings.load_settings()
  )
