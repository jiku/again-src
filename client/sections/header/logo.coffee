Template.logo.rendered = ->
  $(event.currentTarget).addClass 'fadein'

Template.logo.events 'click': (event) ->
  $(event.currentTarget).addClass 'disable-clicks'
