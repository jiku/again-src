Meteor.startup ->
  BlazeLayout.setRoot 'body'

Template.body.rendered = ->
  $('#datgui').show() if Session.get("env") is "dev"
