$ ->
  $('#remote .btn').click ->
    $.get '/moments/operation', { operation: $(this).data('operation') }
