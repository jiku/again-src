SiteEvent = require '/client/events.coffee'

Template.menu.rendered = ->
  Meteor.borderMenu.init()

  SiteEvent.emit 'layout', { template: 'menu', state: 'rendered' }

Template.menu.events
  'click a': (event) ->
    nav = $(event.target).closest('nav')
    nav.toggleClass 'bt-menu-open'
    nav.toggleClass 'bt-menu-close'
