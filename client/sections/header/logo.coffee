SiteEvent = require '/client/events.coffee'

Template.logo.rendered = ->
  @$('div').addClass 'fadein'

Template.logo.events 'click': (event) ->
  SiteEvent.emit 'activateExtra', { from: 'logo' }
