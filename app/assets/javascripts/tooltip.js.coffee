$ ->
  $('.has-popover').popover().on 'click', (e) ->
    e.preventDefault()
    
  $('.has-tooltip').tooltip()
