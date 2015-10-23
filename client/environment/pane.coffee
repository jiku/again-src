Template.pane.rendered = ->
  scroll = ->
    useWrapperForWK = false
    makeWrapper = ->
      $('sections').wrap "<div id='sectionsWrapper'></div>"

    unless jiku?.options?.nativescroll
      makeWrapper()
      relativeContainer = '#sectionsWrapper'
      relativeContent = 'sections'

      onUpdate = ->
        @options.obj.scrolling = true
        @options.obj.data.env.scrollTop = -@y
      myScroll = new IScroll relativeContainer,
        scrollY: true
        probeType: 3
        click: true
        mouseWheel: true
        obj: @
      myScroll.on 'scroll', onUpdate
    else
      if useWrapperForWK
        makeWrapper()
        relativeContainer = '#sectionsWrapper'
        relativeContent = 'sections'
        $(relativeContainer)[0].style.position = "relative"
        $(relativeContainer)[0].style.height = "100vh"
        $(relativeContainer)[0].style.overflowY = "scroll"
      else
        relativeContainer = window
        relativeContent = document

      $(relativeContainer).scroll =>
        @scrolling = true
        @data.env.scrollTop = $(relativeContainer).scrollTop()

    @data.env =
      relativeContainerWidth: if $(relativeContainer).width() > 0 then $(relativeContainer).width() else "100vw"
      relativeContainerHeight: if $(relativeContainer).height() > 0 then $(relativeContainer).height() else "100vh"
      relativeContentHeight: $(relativeContent).height()
      scrollTop: 0 # Initial value

  pane = new Pane 'pane',
    scroll,
    assets: [{
      #   name: 'Julia3Atest2400x'
      #   file: '/1B2_long_title_2400p_mq.jpg'
      #   properties:
      #     offset:
      #       y: 150
      #     alpha: 1
      #     interactive: true },
        name: 'Julia3Atest2400xCosmic'
        file: '/Julia3Atest2400xCosmic.jpg'
        properties:
          blend: 'SCREEN'
          alpha: .5
          interactive: true }, {
        name: 'fog1'
        file: '/fog1.jpg' }, {
        name: 'fog2'
        file: '/smoke-texture-png-wallpaper-1.jpg' }, {
        name: 'fog3'
        file: '/smoke-cloud-texture-wallpaper-2.jpg' }, {
        name: 'Julia3Atest2400x'
        file: '/1B2_long_title_2400p_mq.jpg'
        properties:
          offset:
            y: 150
          alpha: 1
          interactive: true }],
      () ->
        SiteEvent.emit 'layout', { template: 'pane', state: 'rendered' }
        SiteEvent.on 'activate', @onActivate
