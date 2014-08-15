# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  windowHeight = 0
  windowWidth = 0
  $videoContainer = $('#video_container')
  $video = $videoContainer.find('#video')

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

  $(window).on('resize', adjustVideoContainerSize)

  adjustVideoContainerSize()
  initCamera()
