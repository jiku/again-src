Meteor.startup ->
  Session.setDefault 'state', 'init'

onToggleStyle = (type, selector, state) ->
  target = $(selector)
  if selector is "body"
    if state == 'toggle' and target.hasClass('disable-scroll')
      state = 'off'
    else
      state = 'on'
    if state == 'on'
      target.removeClass 'disable-scroll'
    else if state == 'off'
      subsection.addClass 'disable-scroll'
  else if selector is "subsection"
    if state == 'toggle' and target.hasClass('visible')
      state = 'off'
    else
      state = 'on'
    if state == 'on'
      target.addClass('fadein').removeClass('invisible').addClass('visible').removeClass('disable-clicks').removeClass 'disable-selection'
    else if state == 'off'
      target.addClass('fadeout').removeClass('visible').addClass('invisible').addClass('disable-clicks').addClass 'disable-selection'
  else if selector is "menu"
    if state == 'on'
      target.addClass('fadein').removeClass('invisible').addClass('visible').removeClass('disable-clicks').removeClass 'disable-selection'
    else if state == 'off'
      target.addClass('fadeout').removeClass('visible').addClass('invisible').addClass('disable-clicks').addClass 'disable-selection'
SiteEvent.on 'toggleStyle', onToggleStyle
