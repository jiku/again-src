# Template.pane.onCreated = Template.pane.created = ->

Template.pane.onRendered = Template.pane.rendered = ->
  resizeRenderer = ->
    renderer.resize window.innerWidth, window.innerHeight

  renderer = PIXI.autoDetectRenderer 960, 480, { backgroundColor: 0x000000 }
  document.getElementById('pane').appendChild renderer.view

  stage = new (PIXI.Container)
  stage.visible = false
  texture = undefined
  julia2 = undefined
  julia2OffsetY = 150
  fog1 = undefined
  fog2 = undefined
  fog3 = undefined
  scrolling = false
  loader = PIXI.loader
  loader.add('Julia3Atest2400x', '/1B2_long_title_2400p_mq.jpg').add('Julia3Atest2400xCosmic', '/Julia3Atest2400xCosmic.jpg').add('fog1', '/fog1.jpg').add('fog2', '/smoke-texture-png-wallpaper-1.jpg').add('fog3', '/smoke-cloud-texture-wallpaper-2.jpg').once('complete', (loader, resources) ->
    init()
    return
  ).load()
  active = false
  interactive = false
  # var interactivityType = "move";
  interactivityType = 'scroll'
  # "scrollByPercentage";

  valueRatio = (absoluteValue, relativeValue) -> (relativeValue - absoluteValue) / absoluteValue
  valueChange = (absoluteValue, relativeValue, valueRatio) -> absoluteValue * valueRatio + relativeValue

  moveByPercentage = (target, valueRatio, percentage) ->
    yChange = valueChange(window.innerHeight * percentage, target.position.y, valueRatio)
    target.position.y = target.position.y + julia2OffsetY - yChange

  moveTo = (target, valueRatio, coordinates) ->
    yChange = valueChange(coordinates.y, target.position.y, valueRatio)
    target.position.y -= yChange

  onMove = (event) ->
    moveTo event.target, event.target.heightRatio, event.data.global

  animate = (time) ->
    requestAnimationFrame animate
    if scrolling
      scrolling = false
      onScroll ($(window).scrollTop() + $(window).height()) / $(document).outerHeight()
    TWEEN.update time
    renderer.render stage

  init = ->
    julia2 = new (PIXI.Sprite)(loader.resources['Julia3Atest2400x'].texture)
    julia2.name = 'julia2'
    julia2.position.y = julia2OffsetY
    julia2.alpha = 1
    julia2.interactive = true
    stage.addChild julia2
    cosmic = new (PIXI.Sprite)(loader.resources['Julia3Atest2400xCosmic'].texture)
    cosmic.name = 'cosmic'
    cosmic.blendMode = PIXI.BLEND_MODES.SCREEN
    cosmic.alpha = 1
    cosmic.interactive = true
    stage.addChild cosmic
    SiteEvent.emit 'componentState',
      component: 'PixiJS'
      state: 'ready'
    SiteEvent.on 'activate', onActivate

  onActivate = (event) ->
    resize()
    animate()
    tweenTo stage,
      type: 'fadeIn'
      time: 5
    active = true

  resize = (event) ->
    resizeRenderer()
    i = 0
    while i < stage.children.length
      spriteResize stage.children[i]
      i++

  spriteResize = (sprite) ->
    spriteRatio = sprite.width / sprite.height
    spriteMaxWidth = window.innerWidth
    spriteMaxHeight = window.innerHeight
    windowRatio = window.innerWidth / window.innerHeight
    if windowRatio >= spriteRatio
      sprite.width = spriteMaxWidth
      sprite.height = spriteMaxWidth / spriteRatio
    else
      sprite.height = spriteMaxHeight
      sprite.width = spriteMaxHeight * spriteRatio
    sprite.heightRatio = valueRatio(renderer.height, sprite.height)

  tweenTo = (target, data) ->
    if data.type == 'fadeIn'
      target.alpha = 0
      target.visible = true
      properties = alpha: 1
      easingType = TWEEN.Easing.Quadratic.Out
      cb = enableInteractivity
    new (TWEEN.Tween)(target).to(properties, data.time * 1000).easing(easingType).onComplete(cb).start()

  onScroll = (event) ->
    i = 0
    while i < stage.children.length
      moveByPercentage stage.children[i], stage.children[i].heightRatio, event
      i++

  disableInteractivity = ->
    if interactive
      interactive = false
      console.log 'Disabled interactive'
      if interactivityType = 'scroll'
      else if interactivityType == 'move'
        i = 0
        while i < stage.children.length
          stage.children[i].removeListener('mousemove').removeListener 'touchmove'
          i++

  enableInteractivity = ->
    if !interactive
      interactive = true
      console.log 'Enabled interactive'
      if interactivityType = 'scroll'
      else if interactivityType == 'move'
        i = 0
        while i < stage.children.length
          stage.children[i].on('mousemove', onMove).on 'touchmove', onMove
          i++

  window.addEventListener 'resize', resize
  window.addEventListener 'deviceOrientation', resize
  $(window).scroll ->
    scrolling = true
