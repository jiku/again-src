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

onScrollTo = (e) -> controller.scrollTo "##{e?.position}" or ($(window).height() + $(document).outerHeight()), 3

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

onActivate = (e) ->
  SiteEvent.emit 'toggleStyle', 'visibility', 'subsection', 'on'
  SoundEvent.emit 'play', data: 'Play «Priss».' unless Session.get("env") is "dev"

onActivateExtra = (e) ->
  $('section#header').addClass 'disable-clicks'
  SiteEvent.emit 'toggleStyle', 'scroll', 'body', 'on'
  SiteEvent.emit 'toggleStyle', 'visibility', 'menu', 'on'

$(document).on 'click', 'a[href^="/"]', (e) ->
  id = $(this).attr('href').split('/')[1]
  if not (_.isEmpty($("##{id}"))) or (id is FlowRouter.current().path.split('/')[1])
  # if ($("##{id}").length > 0) or (id is FlowRouter.current().path.split('/')[1])
    e.preventDefault()
    SiteEvent.emit 'setHistory', { id: id }
    SiteEvent.emit 'scrollTo', { position: id }

Template.sections.rendered = ->
  _.each sections, (section, i) ->
    scene = new ScrollMagic.Scene(
      triggerElement: 'section#' + section
      triggerHook: _.contains(["0", "#{sections.length - 1}"], i) and "onEnter" or "onLeave"
      offset: _.contains(["0", "#{sections.length - 1}"], i) and "0" or "1"
      )
      .setClassToggle 'a#' + section, 'active'
      .setTween(TweenMax.to('section#' + section, 1, transform: 'opacity(1)', ease: Linear.easeNone))
      .addTo controller
      .on 'start', (e) ->
        unless (Session.get "goTo")
          SiteEvent.emit 'setHistory', { id: @triggerElement?().id }
    scene.addIndicators name: 'SECTION ' + section if Session.get("env") is "dev"

    if (sections.length - 1 is i) and (FlowRouter.getParam 'scrollTo')
      SiteEvent.emit 'scrollTo', { position: FlowRouter.getParam 'scrollTo' }

  SiteEvent.emit 'layout', { template: 'sections', state: 'rendered' }

Template.layoutNormal.rendered = ->
  SiteEvent.on 'scrollTo', onScrollTo
  SiteEvent.on 'toggleStyle', onToggleStyle
  SiteEvent.on 'activate', onActivate
  SiteEvent.on 'activateExtra', onActivateExtra

  SiteEvent.emit 'layout', { template: 'container', state: 'rendered' }
