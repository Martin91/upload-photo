$ ->
  run_click = (selector) ->
    $target = $(selector).first()
    if $target.css('display') != 'none'
      $target.click()

  Operations = {
    take_photo: ->
      run_click('#take_photo')
    close: ->
      run_click('.cancel-photo')
    upload: ->
      run_click('#upload')
  }

  PrivatePub.subscribe "/operations", (data, channel) ->
    operationFunc = Operations[data.operation]
    if operationFunc && (typeof operationFunc == 'function')
      operationFunc()
