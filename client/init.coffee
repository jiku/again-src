Meteor.startup ->
  BlazeLayout.setRoot '#container'

  @jiku = @jiku || {}
  @jiku.again = @jiku.again || {}

  @jiku.again.layouts = [
    name: 'normal'
    templates: [
      { name: 'pane' }
      { name: 'particles' }
      {
        name: 'sections'
        sections: [
          'header'
          'about'
          'player'
          'contribute'
          'footer'
        ]
      }
      { name: 'menu' }
    ]
  ]

  @jiku.again.sections = [
    'header'
    'about'
    'player'
    'contribute'
    'footer'
  ]
  if (Meteor.settings.env is 'dev') then @jiku.again.sections.splice(2, 0, 'crappycrap')

  @jiku.again.externalDirect = false
  @jiku.again.lastPath = ''

  Session.setDefault 'state', 'init'
  Session.set 'goTo', false

  @SiteEvent = new EventEmitter

  if Meteor.settings.public.debugAnalytics then analytics.debug() else analytics.debug(false)
  analytics.identify '123', name: 'Anonymous'

  marked.setOptions breaks: true

  onLayout = (data) ->
    layout = _.find jiku.again.layouts, (l) ->
      l.name is 'normal'

    template = _.find layout.templates, (t) ->
      t.name is data.template

    template?.state = data?.state

    if _.size(layout.templates) is _.size(_.filter layout.templates, (t) -> t.state is 'rendered')
      Session.set 'state', 'normal'

      _.delay -> SiteEvent.emit 'activate', {}, 100
      if jiku.again.externalDirect
        _.delay -> SiteEvent.emit 'activateExtra', {}, 100
      _.each layout.templates, (t) -> t.state = ''
  SiteEvent.on 'layout', onLayout

  onSetHistory = (e) ->
    unless Session.equals("lastHistory", e.id)
      Session.set "lastHistory", e.id
      document.title = "Again (jiku): #{e.id}"
      window.history.pushState {}, "Again (jiku): #{e.id}", "#{e.id}"
      analytics.page e.id
  SiteEvent.on 'setHistory', onSetHistory

Template.body.rendered = ->
  $('#datgui').show() if Session.get("env") is "dev"
