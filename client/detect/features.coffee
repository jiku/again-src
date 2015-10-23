Meteor.startup ->
  if Modernizr and jiku
    jiku.features ?= {}
    jiku.features.webview = if Modernizr.indexeddb then "WK" else "UI" # Seems to be the best test for it
    jiku.features.webgl = if Modernizr.webgl then true else false

    jiku.options ?= {}
    jiku.options.nativescroll = if (jiku.features.webview is "UI") then false else true
