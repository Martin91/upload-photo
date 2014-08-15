# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  windowHeight = 0
  windowWidth = 0
  $videoContainer = $('#video_container')
  $video = $videoContainer.find('#video')
  $canvas = $('#canvas')
  $modal = $('#upload_photo_modal')

  retrieveWindowSize = ->
    windowHeight = $(window).height()
    windowWidth = $(window).width()

  setVideoContainerSize = ->
    $videoContainer.css
      widht: windowWidth
      height: windowHeight

  adjustVideoContainerSize = ->
    retrieveWindowSize()
    setVideoContainerSize()

  gotStream = (stream) ->
    $video.attr 'src', URL.createObjectURL(stream)
    $video[0].play()

  missedStream = ->
    console.log("Failed to access the webcam!")

  initCamera = ()->
    constraints = { video: true }
    getUserMedia(constraints, gotStream, missedStream)

  takePicture = ->
    videoWidth = $video.innerWidth()
    videoHeight = $video.innerHeight()
    $canvas.attr
      width: videoWidth
      height: videoHeight
    $canvas[0].getContext('2d').drawImage($video[0], 0, 0, videoWidth, videoHeight)
    data = $canvas[0].toDataURL('image/png')
    $modal.find('#preview').attr('src', data)
    $modal.modal('show')

  adjustVideoContainerSize()
  initCamera()

  $(window).on('resize', adjustVideoContainerSize)

  $('#take_photo').click ->
    $(video)[0].pause()
    takePicture()
    $('.buttons-group .btn').toggle()

  $modal.on 'hidden.bs.modal', ->
    $(video)[0].play()
    $('.buttons-group .btn').toggle()

  handleSuccessUpload = (data) ->

  $('#upload').click ->
    photoUrl = $('#preview').attr('src')
    console.log "图片来自：#{photoUrl}"
    $.post "/moments", {'moment[photo]': photoUrl}, handleSuccessUpload

