marked.setOptions breaks: true

controller = new ScrollMagic.Controller

controller.scrollTo (target, time = 0.5) ->
  Session.set "goTo", true
  TweenMax.to window, time,
    scrollTo:
      y: target
      autoKill: true
      onAutoKill: ->
        Session.set "goTo", false
    ease: Cubic.easeInOut
    onComplete: ->
      Session.set "goTo", false

$(document).on 'click', 'a[href^="/"]', (e) ->
  id = $(this).attr('href').split('/')[1]
  if ($(id).length > 0) or (id is FlowRouter.current().path.split('/')[1])
    e.preventDefault()
    SiteEvent.emit 'scrollTo', { position: id }

Template.container.rendered = ->
  Meteor.borderMenu.init()

  i = 0
  while i < sections.length
    section = new ScrollMagic.Scene(
      triggerElement: 'section#' + sections[i]
      triggerHook: _.contains(["0", "#{sections.length - 1}"], i) and "onEnter" or "onLeave"
      offset: _.contains(["0", "#{sections.length - 1}"], i) and "0" or "1"
      )
      .setClassToggle 'a#' + sections[i], 'active'
      .setTween(TweenMax.to('section#' + sections[i], 1, transform: 'opacity(1)', ease: Linear.easeNone))
      .addTo controller
      .on 'start', (e) ->
        unless Session.get "goTo"
          document.title = "Again (jiku): #{@triggerElement?().id}"
          window.history.pushState {}, "Again (jiku): #{@triggerElement?().id}", "#{@triggerElement?().id}"
    section.addIndicators name: 'SECTION ' + sections[i] if Session.get("env") is "dev"
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
    toggleScroll 'body', 'on'
    toggleSubSection 'subsection', 'on'
    toggleMenu 'Menu', 'on'

  SiteEvent.on 'activate', onActivate

  onScrollTo = (e) -> controller.scrollTo "##{e?.position}" or ($(window).height() + $(document).outerHeight()), 6

  SiteEvent.on 'scrollTo', onScrollTo
