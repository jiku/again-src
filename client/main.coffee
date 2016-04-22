require './lib/routes.js'
require './events.coffee'
require './init.coffee'
require './index.jade'

if Meteor.settings.public.datgui
  @datgui = require('meteor/jiku:datgui') # To global for now
