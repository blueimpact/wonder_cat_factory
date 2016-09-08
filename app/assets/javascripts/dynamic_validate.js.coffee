$ ->
  $.fn.is_value_changed = ->
    $(this).val() != $(this).data('last-value')
  $.fn.is_value_original = ->
    $(this).val() == $(this).data('original-value')
  $.fn.apply_value_change = ->
    $(this).data('last-value', $(this).val())
  validate_control = ->
    if $(this).is_value_changed()
      $(this).apply_value_change()
      div = $(this).closest('.form-group')
      if $(this).is_value_original()
        div.removeClass('has-error has-success')
        div.find('.form-control-feedback .fa').
        removeClass('fa-times fa-check fa-spinner fa-spin')
        div.find('.help-block').text('')
      else
        window.console.log 'querying...'
        $.ajax
          type: 'GET'
          url: $(this).closest('form').data('dynamic-validate')
          data: {
            'context': $(this).closest('form').data('dynamic-validate-context')
            'user[email]': $('#user_email').val()
            'user[password]': $('#user_password').val()
            'user[label]': $('#user_label').val()
            'user[username]': $('#user_username').val()
          }
          dataType: 'json'
          encode: true
          beforeSend: ->
            div.find('.form-control-feedback .fa').
            removeClass('fa-times fa-check').
            addClass('fa-spinner fa-spin')
          success: (data)->
            attr = div.find('input').attr('id').slice(5)
            errors = data[attr]
            if errors.length == 0
              div.removeClass('has-error').addClass('has-success')
              div.find('.form-control-feedback .fa').
              removeClass('fa-times fa-spinner fa-spin').
              addClass('fa-check')
              div.find('.help-block').text('')
            else
              div.addClass('has-error').removeClass('has-success')
              div.find('.form-control-feedback .fa').
              removeClass('fa-check fa-spinner fa-spin').
              addClass('fa-times')
              div.find('.help-block').text(errors[0])
  for e in $('form[data-dynamic-validate] input')
    $(e).on 'change keyup mouseup', _.debounce(validate_control, 500)
    $(e).data('original-value', $(e).val())
    $(e).apply_value_change()
