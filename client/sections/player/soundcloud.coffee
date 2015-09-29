soundCloudPlayer = new jikuPlayer.SoundCloud "5ae0c6ffd01e8b8580395dd8cfaa1e0f" # "88c2c2e7c8e0b195166bee3c33f58368" # Secret
soundCloudPlayer.load { permalink: "jiku/sets/again" }

Template.soundcloud.onCreated = Template.soundcloud.created = ->
  SoundEvent.on 'play', soundCloudPlayer.play

Template.soundcloud.onRendered = Template.soundcloud.rendered = ->
  SiteEvent.emit 'componentState',
    component: 'SoundCloud'
    state: 'ready'

Template.soundcloud.onDestroyed = Template.soundcloud.destroyed = ->
  SoundEvent.removeListener 'play', soundCloudPlayer.play
