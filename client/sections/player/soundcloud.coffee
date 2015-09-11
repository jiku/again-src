AudioContext = undefined
audio = undefined
audioContext = undefined
source = undefined
streamUrl = undefined
clientParameter = 'client_id=5ae0c6ffd01e8b8580395dd8cfaa1e0f'
trackPermalinkUrl = 'https://soundcloud.com/jiku/priss'

initAudio = ->
  AudioContext = window.AudioContext or window.webkitAudioContext
  audio = new Audio
  audio.crossOrigin = 'anonymous'
  audioContext = new AudioContext
  source = audioContext.createMediaElementSource(audio)
  source.connect audioContext.destination
  audio.src = streamUrl
  audio.play()

get = (url, callback) ->
  request = new XMLHttpRequest

  request.onreadystatechange = ->
    if request.readyState == 4 and request.status == 200
      callback request.responseText

  request.open 'GET', url, true
  request.send null

findTrack = ->
  get 'http://api.soundcloud.com/resolve.json?url=' + trackPermalinkUrl + '&' + clientParameter, (response) ->
    trackInfo = JSON.parse(response)
    streamUrl = trackInfo.stream_url + '?' + clientParameter
    initAudio()

onPlay = (track) ->
  console.log 'Listening custom event', track
  # Should contain what track to play, etc...
  findTrack()

# Template.soundcloud.onCreated = Template.soundcloud.created = ->
#   SoundEvent.on 'play', onPlay

Template.soundcloud.onRendered = Template.soundcloud.rendered = ->
  SiteEvent.emit 'componentState',
    component: 'SoundCloud'
    state: 'ready'

Template.soundcloud.onDestroyed = Template.soundcloud.destroyed = ->
  SoundEvent.removeListener 'play', onPlay
