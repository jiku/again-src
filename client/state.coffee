Meteor.startup ->
  Session.setDefault 'state', 'init'
  Session.setDefault 'statePixiJS', 'unready'
  Session.setDefault 'stateThreeJS', 'unready'
  Session.setDefault 'stateSoundCloud', 'unready'
  Session.setDefault 'componentStates', []

onComponentState = (data) ->
  Session.set 'state' + data.component, data.state
  if Session.equals('state', 'init') and Session.equals('statePixiJS', 'ready') and Session.equals('stateThreeJS', 'ready') and Session.equals('stateSoundCloud', 'ready')
    Session.set 'state', 'intro'

SiteEvent.on 'componentState', onComponentState
