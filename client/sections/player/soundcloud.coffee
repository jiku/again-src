soundCloudPlayer = new jikuPlayer.SoundCloud "5ae0c6ffd01e8b8580395dd8cfaa1e0f" # "88c2c2e7c8e0b195166bee3c33f58368" # Secret
soundCloudPlayer.load { permalink: "jiku/sets/again" }

# Template.soundcloud.onRendered didn't work? Weird.
Template.soundcloud.rendered = ->
  # Nice test...
  # SoundEvent.on 'play', (e) -> console.log "HEY THERE! #{JSON.stringify e}"
  SoundEvent.on 'play', soundCloudPlayer.play

  SiteEvent.emit 'componentState',
    component: 'SoundCloud'
    state: 'ready'
