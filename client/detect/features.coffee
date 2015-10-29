Meteor.startup ->
  if Modernizr and jiku
    jiku.features ?= {}
    jiku.features.webview = if Modernizr.indexeddb then "WK" else "UI" # Seems to be the best test for it
    jiku.features.webgl = if Modernizr.webgl then true else false

    if datgui
      featureGUI = datgui.addFolder 'Features'
      featureGUI.closed = false
      featureGUI.add(jiku.features, 'webview').listen()
      featureGUI.add(jiku.features, 'webgl').listen()

    jiku.options ?= {}
    jiku.options.nativescroll = if (jiku.features.webview is "UI") then false else true

    if datgui
      optionsGUI = datgui.addFolder 'Options'
      optionsGUI.closed = false
      optionsGUI.add(jiku.options, 'nativescroll').listen()

    if datgui
      viewport = window
      viewportGUI = datgui.addFolder 'Viewport'
      viewportGUI.closed = false
      viewportGUI.add(viewport, 'innerWidth').listen()
      viewportGUI.add(viewport, 'innerHeight').listen()
      viewportGUI.add(viewport, 'outerWidth').listen()
      viewportGUI.add(viewport, 'outerHeight').listen()
