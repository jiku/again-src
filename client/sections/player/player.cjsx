React = require 'react'
Player = require '/imports/modules/Soundplayer/client/Soundplayer.jsx'

Template.sections.helpers
  Player: ->
    Player.default
