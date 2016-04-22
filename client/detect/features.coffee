require 'meteor/jiku:modernizr' # Global for now
Data = require '/client/data.coffee'

Meteor.startup ->
  if Modernizr and Data.site
    Data.site.features ?= {}
    Data.site.features.webview = if Modernizr.indexeddb then "WK" else "UI" # Seems to be the best test for it
    Data.site.features.webgl = if Modernizr.webgl then true else false

    Data.site.options ?= {}
    Data.site.options.nativescroll = if (Data.site.features.webview is "UI") then false else true

    if datgui?.domElement?
      featureGUI = datgui.addFolder 'Features'
      featureGUI.closed = false
      featureGUI.add(Data.site.features, 'webview').listen()
      featureGUI.add(Data.site.features, 'webgl').listen()

      optionsGUI = datgui.addFolder 'Options'
      optionsGUI.closed = false
      optionsGUI.add(Data.site.options, 'nativescroll').listen()

      viewport = window
      viewportGUI = datgui.addFolder 'Viewport'
      viewportGUI.closed = false
      viewportGUI.add(viewport, 'innerWidth').listen()
      viewportGUI.add(viewport, 'innerHeight').listen()
      viewportGUI.add(viewport, 'outerWidth').listen()
      viewportGUI.add(viewport, 'outerHeight').listen()
