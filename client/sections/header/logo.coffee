Template.logo.rendered = ->
  $(event.currentTarget).addClass 'fadein'

Template.logo.events 'click': (event) ->
  SiteEvent.emit 'activateExtra', { from: 'logo' }
