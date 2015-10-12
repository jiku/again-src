if Meteor.isClient
  @layouts = [{
      name: 'normal'
      templates: [{
        name: 'pane'
      }, {
        name: 'soundcloud'
      }, {
        name: 'particles'
      }, {
        name: 'sections'
        sections: ['header', 'about', 'player', 'contribute', 'footer']
      }, {
        name: 'menu'
      }]
    }]

  @sections = [
    'header'
    'about'
    'player'
    'contribute'
    'footer'
  ]
  @sections.splice(2, 0, "crappycrap") if Meteor.settings.env is "dev"

  @externalDirect = true
  @lastPath = ""

  Session.set "goTo", false

  render = (args) ->
    # I.e. uses default templates unless provided
    BlazeLayout.render 'layoutNormal',
      pane: args?.templates?.pane or 'pane'
      soundcloud: args?.templates?.soundcloud or 'soundcloud'
      particles: args?.templates?.particles or 'particles'
      sections: args?.templates?.sections or 'sections'
      menu: args?.templates?.menu or 'menu'

  FlowRouter.route '/',
    name: 'home'
    action: (params, queryParams) =>
      @externalDirect = false
      render()

  FlowRouter.route '/:scrollTo',
    name: 'home_scroll'
    triggersEnter: [(context, redirect) ->
      unless _.contains sections, context.path.split('/')[1]
        redirect '/'
    ]
    action: (params, queryParams) =>
      # From external, template takes care of internal
      if _.isEmpty(lastPath) and (_.contains sections, params.scrollTo)
        @externalDirect = true
        render()

  setLastPath = (context, redirect, stop) -> lastPath = context.path.split('/')[1]

  FlowRouter.notFound = action: -> redirect '/'

  FlowRouter.triggers.exit [setLastPath]
