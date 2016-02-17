$ ->
  $('.image-gallery [data-image]').click (e) ->
    src = $(@).data('image')
    $(@).closest('.image-gallery').find(".image-main img").hide()
    $(@).closest('.image-gallery').find(".image-main img[src='#{src}']").show()
    $(@).closest('.image-gallery').find('[data-image]').removeClass('active')
    $(@).addClass('active')
    e.preventDefault()
  $('.image-gallery [data-image]').mouseenter (e) ->
    $(@).trigger('click')
  for e in $('.image-gallery .image-main img')
    $(e).hide().attr('src', $(e).data('src'))
  for e in $('.image-gallery .image-main')
    $(e).closest('.image-gallery').find('[data-image]').first().trigger('click')

  for e in $('.image-zoom')
    $(e).zoom(url: $(e).data('url'))
