@sections = [
  'header'
  'about'
  'player'
  'contribute'
  'footer'
]

@sections.splice 2, 0, "crappycrap" if (Meteor.settings.env is "dev")

if Meteor.isClient
  Session.set "goTo", false

lastPath = ""

FlowRouter.route '/',
  name: 'home'
  action: (params, queryParams) ->
    BlazeLayout.render 'container',
      pane: 'pane'
      soundcloud: 'soundcloud'
      particles: 'particles'
      sections: 'sections'
      menu: 'menu'

FlowRouter.route '/:scrollTo',
  name: 'home_scroll'
  triggersEnter: [(context, redirect) ->
    unless _.contains sections, context.path.split('/')[1]
      redirect '/'
  ]
  action: (params, queryParams) ->
    init = () ->
      Session.set 'state', 'normal'
      SiteEvent.emit 'activate', {}
      SoundEvent.emit 'play', data: 'Play «Priss».' unless (Session.get "env" is "dev")
      BlazeLayout.render 'container',
        pane: 'pane'
        soundcloud: 'soundcloud'
        particles: 'particles'
        sections: 'sections'
        menu: 'menu'

    # From external
    if _.isEmpty(lastPath) and (_.contains sections, params.scrollTo)
      init()
    SiteEvent.emit 'scrollTo', { position: params.scrollTo }

setLastPath = (context, redirect, stop) -> lastPath = context.path.split('/')[1]

FlowRouter.notFound = action: -> redirect '/'

FlowRouter.triggers.exit [setLastPath]
