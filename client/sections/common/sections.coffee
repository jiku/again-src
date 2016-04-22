FlowRouter = require 'meteor/kadira:flow-router'
_ = require 'meteor/underscore'

Template.sections.helpers
  hasReactComponent: ->
    !_.isUndefined FlowRouter.current().route.options.reactComponent
  reactComponent: ->
    FlowRouter.current().route.options.reactComponent()
