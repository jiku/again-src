if Meteor.isServer
  Meteor.startup ->
    WebAppInternals.setBundledJsCssPrefix Meteor.settings.public.cdn
