# Template.pane.onCreated = Template.pane.created = ->

Template.pane.rendered = ->
  pane = new Pane 'pane', assets: [
    # {
    #   name: 'Julia3Atest2400x'
    #   file: '/1B2_long_title_2400p_mq.jpg'
    #   properties:
    #     offset:
    #       y: 150
    #     alpha: 1
    #     interactive: true
    # },
    {
      name: 'Julia3Atest2400xCosmic'
      file: '/Julia3Atest2400xCosmic.jpg'
      properties:
        blend: 'SCREEN'
        alpha: .5
        interactive: true
    },
    {
      name: 'fog1'
      file: '/fog1.jpg'
    },
    {
      name: 'fog2'
      file: '/smoke-texture-png-wallpaper-1.jpg'
    },
    {
      name: 'fog3'
      file: '/smoke-cloud-texture-wallpaper-2.jpg'
    },
    {
      name: 'Julia3Atest2400x'
      file: '/1B2_long_title_2400p_mq.jpg'
      properties:
        offset:
          y: 150
        alpha: 1
        interactive: true
    }
  ], () ->
    SiteEvent.emit 'layout', { template: 'pane', state: 'rendered' }
    SiteEvent.on 'activate', @onActivate
