Meteor.startup ->
  BlazeLayout.setRoot 'body'

  onLayout = (data) ->
    layout = _.find layouts, (l) ->
      l.name is 'normal'

    template = _.find layout.templates, (t) ->
      t.name is data.template

    template?.state = data?.state

    if _.size(layout.templates) is _.size(_.filter layout.templates, (t) -> t.state is 'rendered')
      Session.set 'state', 'normal'
      setTimeout activate, 100
      if externalDirect
        setTimeout activateExtra, 100
      _.each layout.templates, (t) -> t.state = ''

  SiteEvent.on 'layout', onLayout

  activate = ->
    SiteEvent.emit 'activate', {}
  activateExtra = ->
    SiteEvent.emit 'activateExtra', {}

  onSetHistory = (e) ->
    unless Session.equals("lastHistory", e.id)
      Session.set "lastHistory", e.id
      document.title = "Again (jiku): #{e.id}"
      window.history.pushState {}, "Again (jiku): #{e.id}", "#{e.id}"
      analytics.page e.id
  SiteEvent.on 'setHistory', onSetHistory

Template.body.rendered = ->
  $('#datgui').show() if Session.get("env") is "dev"