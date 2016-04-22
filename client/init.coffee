SiteEvent = require '/client/events.coffee'
Data = require '/client/data.coffee'
marked = require('meteor/chuangbo:marked').marked

Meteor.startup ->
  BlazeLayout.setRoot '#container'

  Session.setDefault 'state', 'init'
  Session.set 'goTo', false

  if Meteor.settings.public.debugAnalytics then analytics.debug() else analytics.debug(false)
  analytics.identify '123', name: 'Anonymous'

  marked.setOptions breaks: true

  onLayout = (data) ->
    layout = _.find Data.site.layouts, (l) ->
      l.name is 'normal'

    template = _.find layout.templates, (t) ->
      t.name is data.template

    template?.state = data?.state

    if _.size(layout.templates) is _.size(_.filter layout.templates, (t) -> t.state is 'rendered')
      Session.set 'state', 'normal'

      _.delay -> SiteEvent.emit 'activate', {}, 100
      if Data.site.externalDirect
        _.delay -> SiteEvent.emit 'activateExtra', {}, 100
      _.each layout.templates, (t) -> t.state = ''
  SiteEvent.on 'layout', onLayout

  onSetHistory = (e) ->
    unless Session.equals("lastHistory", e.id)
      Session.set "lastHistory", e.id
      document.title = "Again (jiku): #{e.id}"
      window.history.pushState {}, "Again (jiku): #{e.id}", "#{Data.site.base_uri + e.id}"
      analytics.page e.id
  SiteEvent.on 'setHistory', onSetHistory

Template.body.rendered = ->
  $('#datgui').show() if Session.get("env") is "dev"
