$ ->
  $('#events').infinitescroll
    navSelector: '#events .pagination' # selector for the paged navigation (it will be hidden)
    nextSelector: '#events .pagination a[rel=next]' # selector for the NEXT link (to page 2)
    itemSelector: '#events .event-row' # selector for all items you'll retrieve
    loading:
      msgText: 'Loading the next events...'
      finishedMsg: 'No more events.'
