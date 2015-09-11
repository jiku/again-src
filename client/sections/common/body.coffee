@SiteEvent = new EventEmitter
@SoundEvent = new EventEmitter

marked.setOptions breaks: true

Meteor.startup ->
  Session.setDefault 'state', 'init'
  Session.setDefault 'statePixiJS', 'unready'
  Session.setDefault 'stateThreeJS', 'unready'
  Session.setDefault 'stateSoundCloud', 'unready'
  Session.setDefault 'componentStates', []

controller = new (ScrollMagic.Controller)

controller.scrollTo (target, time) ->
  if time == undefined
    time = 0.5
  TweenMax.to window, time,
    scrollTo:
      y: target
      autoKill: true
    ease: Cubic.easeInOut

$(document).on 'click', 'a[href^=#]', (e) ->
  id = $(this).attr('href')
  if $(id).length > 0
    e.preventDefault()
    controller.scrollTo id

Template.body.onCreated = Template.body.created = ->
  onComponentState = (data) ->
    Session.set 'state' + data.component, data.state
    if Session.equals('state', 'init') and Session.equals('statePixiJS', 'ready') and Session.equals('stateThreeJS', 'ready') and Session.equals('stateSoundCloud', 'ready')
      Session.set 'state', 'intro'

  SiteEvent.on 'componentState', onComponentState

Template.body.onRendered = Template.body.rendered = ->
  Meteor.borderMenu.init()

  sections = []
  if Session.get('isProdEnvironment')
    sections = [
      'header'
      'about'
      'player'
      'contribute'
      'footer'
    ]
  else
    sections = [
      'header'
      'about'
      'player'
      'crappycrap'
      'contribute'
      'footer'
    ]
  i = 0
  while i < sections.length
    name = 'SECTION ' + sections[i]
    section = new (ScrollMagic.Scene)(
      triggerElement: 'section#' + sections[i]
      slider: 'right').setClassToggle('a#' + sections[i], 'active').setTween(TweenMax.to('section#' + sections[i], 1,
      transform: 'opacity(1)'
      ease: Linear.easeNone)).addTo(controller)
    if Session.get('isProdEnvironment')
      section.addIndicators name: name
    i++

  toggleScroll = (selector, state) ->
    target = $(selector)
    if state == 'toggle' and target.hasClass('disable-scroll')
      state = 'off'
    else
      state = 'on'
    if state == 'on'
      target.removeClass 'disable-scroll'
    else if state == 'off'
      subsection.addClass 'disable-scroll'

  toggleSubSection = (selector, state) ->
    target = $(selector)
    if state == 'toggle' and target.hasClass('visible')
      state = 'off'
    else
      state = 'on'
    if state == 'on'
      target.addClass('fadein').removeClass('invisible').addClass('visible').removeClass('disable-clicks').removeClass 'disable-selection'
    else if state == 'off'
      target.addClass('fadeout').removeClass('visible').addClass('invisible').addClass('disable-clicks').addClass 'disable-selection'

  toggleMenu = (selector, state) ->
    target = $(selector)
    if state == 'on'
      target.addClass('fadein').removeClass('invisible').addClass('visible').removeClass('disable-clicks').removeClass 'disable-selection'
    else if state == 'off'
      target.addClass('fadeout').removeClass('visible').addClass('invisible').addClass('disable-clicks').addClass 'disable-selection'

  onActivate = (event) ->
    controller.scrollTo $(window).height() + $(document).outerHeight(), 6
    toggleScroll 'body', 'on'
    toggleSubSection 'subsection', 'on'
    toggleMenu 'Menu', 'on'

  SiteEvent.on 'activate', onActivate
