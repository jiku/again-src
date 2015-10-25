soundCloudPlayer = new jikuPlayer.SoundCloud Meteor.settings.public.soundcloud.key
soundCloudPlayer.load { permalink: "jiku/sets/again" }

Template.soundcloud.rendered = ->
  SoundEvent.on 'play', soundCloudPlayer.play
  SiteEvent.emit 'layout', { template: 'soundcloud', state: 'rendered' }

Template.soundcloud.onDestroyed = ->
  SoundEvent.removeListener 'play', soundCloudPlayer.play
