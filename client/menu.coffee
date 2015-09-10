Template.menu.events
  'click a': (event) ->
    nav = $(event.target).closest('nav')
    nav.toggleClass 'bt-menu-open'
    nav.toggleClass 'bt-menu-close'
