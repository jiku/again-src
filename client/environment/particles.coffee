Template.particles.rendered = ->
  logo = new jikuThree.Scene 'particles', objects: [
    {
      type: "ParticlesGPUSystem"
    },
    {
      type: "ParticlesSprites"
    },
    {
      type: "Text"
      data:
        typeface:
          font: 'jikutype-001'
          weight: 'normal'
          style: 'vector'
        text: "jiku"
    }
  ], () ->
    SiteEvent.emit 'layout', { template: 'particles', state: 'rendered' }
