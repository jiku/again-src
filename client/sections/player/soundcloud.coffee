soundCloudPlayer = new jikuPlayer.SoundCloud "5ae0c6ffd01e8b8580395dd8cfaa1e0f" # "88c2c2e7c8e0b195166bee3c33f58368" # Secret
soundCloudPlayer.load { permalink: "jiku/sets/again" }

Template.soundcloud.rendered = ->
  SoundEvent.on 'play', soundCloudPlayer.play
  SiteEvent.emit 'layout', { template: 'soundcloud', state: 'rendered' }

Template.soundcloud.onDestroyed = ->
  SoundEvent.removeListener 'play', soundCloudPlayer.play
