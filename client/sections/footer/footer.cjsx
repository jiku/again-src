Template.footer.rendered = ->
  Meteor.call 'RenderSocial', (error, data) -> ""
