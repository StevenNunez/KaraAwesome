# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

current_selection = ->
  if location.search
    selection = location.search.match(/selection_id=(\d.*)/)[1]
    $('*[data-id="'+ selection + '"]')
  else
    $('*[data-id]').first()

removeAndPlayNext = (current_selection) ->
  $.ajax
    url: '/selections/' + current_selection.data('id')
    type: 'DELETE'
    success: (result) ->
      next_selection = current_selection.next()
      if next_selection[0]
        location.href =  '?selection_id=' + next_selection.data('id')

$ ->
  tag = document.createElement('script')
  tag.src = "https://www.youtube.com/iframe_api"
  firstScriptTag = document.getElementsByTagName('script')[0]
  firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

  player = null
  window.onYouTubeIframeAPIReady = ->
    player = new YT.Player 'player',
      videoId: $('#player').data('current-id')
      events:
        'onReady': onPlayerReady
        'onStateChange': onPlayerStateChange

  onPlayerReady = (event) ->
    event.target.playVideo()

  onPlayerStateChange = (event) ->
    if event.data is YT.PlayerState.ENDED
      removeAndPlayNext(current_selection())


  $('.remove-from-playlist').on 'ajax:success', (e, data) ->
    if current_selection().data('id') is parseInt(data)
      removeAndPlayNext(current_selection())
    else
      $("*[data-id=#{data}]").remove()
