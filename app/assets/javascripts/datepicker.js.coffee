$ ->
  for e in $('.datepicker')
    date = $(e).find('input').val()
    $(e).datetimepicker
      format: 'YYYY-MM-DD'
      dayViewHeaderFormat: 'YYYY MMMM'
      defaultDate: date
      icons:
        time: 'fa fa-time',
        date: 'fa fa-calendar',
        up: 'fa fa-chevron-up',
        down: 'fa fa-chevron-down',
        previous: 'fa fa-chevron-left',
        next: 'fa fa-chevron-right',
        today: 'fa fa-screenshot',
        clear: 'fa fa-trash',
        close: 'fa fa-remove'
