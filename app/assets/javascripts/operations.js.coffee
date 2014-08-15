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

  if $('#video_container').length
    PrivatePub.subscribe "/operations", (data, channel) ->
      console.log "监听到操作请求：#{data.operation}"

      operationFunc = Operations[data.operation]
      if operationFunc && (typeof operationFunc == 'function')
        operationFunc()
