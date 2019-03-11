if Meteor.isServer
  Meteor.startup ->
    # WebAppInternals.setBundledJsCssPrefix Meteor.settings.public.paths.cdn

    WebApp.rawConnectHandlers.use (req, res, next) ->
      res.setHeader 'cache-control', 'public'
      res.setHeader 'expires', '31536000'
      res.setHeader 'max-age', '31536000'
      res.setHeader 'charset', 'utf-8'
      next()
