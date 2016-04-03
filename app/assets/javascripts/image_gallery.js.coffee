$ ->
  $('.image-gallery [data-toggle="tab"]:first').trigger('click')

  for e in $('.image-zoom img')
    $(e).parent().zoom(url: $(e).attr('src'))
