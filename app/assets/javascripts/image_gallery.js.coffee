$ ->
  $('.image-gallery [data-image]').click (e) ->
    src = $(@).data('image')
    $(@).closest('.image-gallery').find('.image-main').attr('src', src)
    $(@).closest('.image-gallery').find('[data-image]').removeClass('active')
    $(@).addClass('active')
    e.preventDefault()
  $('.image-gallery [data-image]').mouseenter (e) ->
    $(@).trigger('click')
  for e in $('.image-gallery .image-main')
    $(e).closest('.image-gallery').find('[data-image]').first().trigger('click')
