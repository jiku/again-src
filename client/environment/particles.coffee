Template.particles.rendered = ->
  logo = new jikuThree.Scene 'particles',
  # postprocessing: true
  links: [{ # Applies to the whole scene...
    animationEvent: # Some things you have to do when moving camera from animationFrame
      type: 're'
      update: ->
        @camera.position.x += (@interactive.position.x - @camera.position.x) * 0.05
        @camera.position.y += (-@interactive.position.y - @camera.position.y) * 0.05
        @camera.lookAt @scene.position
      # audio: # Some things you have to do when moving camera from audio
  }, {
    audioEvent:
      emitter: "soundcloud" # Which audio...
      type: 'er'
      moveCamera: # Method to execute
        x: ['mouse.x', 'audio.amp'] # I.e. if mouse.x, use that... if audio.amp, use that... Maybe it could combine them too...
        y: ['mouse.y', 'audio.amp']
        const: 0.05
  }, {
    audioEvent: # directions to Interactive
      emitter: "soundcloud" # Which audio...
      type: 're'
      amplitude:
        min: 0
        max: 100
      freq:
        target: "1000" # Hz
  }]
  datgui: ->
    @options =
      rotationWrap: 'mean'
      scaleWrap: 'mean'
    gui = @gui.addFolder 'Particles scene'
    rotationGUI = gui.addFolder 'Rotation'
    rotationGUI.add(@scene.rotation, 'x', 0, 360).listen()
    rotationGUI.add(@scene.rotation, 'y', 0, 360).listen()
    rotationGUI.add(@scene.rotation, 'z', 0, 360).listen()
    rotationGUI.add @options, 'rotationWrap', ['mean', 'median'] # Object.getOwnPropertyNames(math) # Can break everything
    scaleGUI = gui.addFolder 'Scale'
    scaleGUI.add(@scene.scale, 'x', -100, 100).listen()
    scaleGUI.add(@scene.scale, 'y', -100, 100).listen()
    scaleGUI.add(@scene.scale, 'z', -100, 100).listen()
    scaleGUI.add @options, 'scaleWrap', ['mean', 'median'] # Object.getOwnPropertyNames(math) # Can break everything
  update: ->
    # @camera.position.x += (@interactive.position.x - @camera.position.x) * 0.05
    # debugger
    # x = (math.mean(Array.from(@audio.timeDomainData())) / window.innerWidth) * 100
    # y = (math.mean(Array.from(@audio.frequencyData())) / window.innerHeight) * 100

    # @camera.position.x += (x - @camera.position.x) * 0.05
    # @camera.position.y += (-@interactive.position.y - @camera.position.y) * 0.05
    # @camera.position.y += (y - @camera.position.y) * 0.05
    @camera.position.x += (@interactive.position.x - @camera.position.x) * 0.05
    @camera.position.y += (-@interactive.position.y - @camera.position.y) * 0.05
    @camera.lookAt @scene.position
    # console.log "x: #{x}, y: #{y}"
  interactive: true
  objects: [
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
        links:
          size:
            audio:
              context: "soundcloud"
              amplitude:
                min: 0
                max: 100
              freq:
                target: "1000" # Hz
        datgui: ->
          # @gui = new dat.GUI
          @options =
            rotation:
              x: 0
              y: 0
              z: 0
            scale:
              x: 1
              y: 1
              z: 1
            rotationWrap: 'mean'
            scaleWrap: 'mean'
          gui = @gui.addFolder 'jiku Logo'
          @gui.remember @options # scaleGUI #@group # None work...
          @gui.remember @options.rotation # scaleGUI #@group # None work...
          @gui.remember @options.scale # scaleGUI #@group # None work...
          # @gui.remember 'jiku Logo' # scaleGUI #@group # None work...
          rotationGUI = gui.addFolder 'Rotation'
          rotationGUI.add(@options.rotation, 'x', 0, 360).listen()
          rotationGUI.add(@options.rotation, 'y', 0, 360).listen()
          rotationGUI.add @options.rotation, 'z', 0, 360 # ).listen()
          rotationGUI.add @options, 'rotationWrap', ['mean', 'median'] # Object.getOwnPropertyNames(math) # Can break everything
          scaleGUI = gui.addFolder 'Scale'
          scaleGUI.add(@options.scale, 'x', 0.0, 100).listen()
          scaleGUI.add(@options.scale, 'y', 0.1, 100).listen()
          scaleGUI.add(@options.scale, 'z', 0.0, 100).listen()
          scaleGUI.add @options, 'scaleWrap', ['mean', 'median'] # Object.getOwnPropertyNames(math) # Can break everything
        update: ->
          # x = @interactive.position.x
          # y = -@interactive.position.y

          x = (math[@options.scaleWrap](Array.from(@audio.timeDomainData())))
          y = (math[@options.scaleWrap](Array.from(@audio.frequencyData())))
          xDeltaCalc = x * 0.01
          yDeltaCalc = y * 0.01

          # @options.rotation.x = xDeltaCalc
          # @options.rotation.y = yDeltaCalc
          # @options.rotation.z = xDeltaCalc / yDeltaCalc

          @options.scale.x = jikuHelpers.placeInRange(xDeltaCalc, 0.1, 2)
          @options.scale.y = jikuHelpers.placeInRange(yDeltaCalc, 0.1, 2)
          @options.scale.z = jikuHelpers.placeInRange(xDeltaCalc / yDeltaCalc, 0.1, 2)

          # @group.rotation.x = @options.rotation.x
          # @group.rotation.y = @options.rotation.y
          # @group.rotation.z = @options.rotation.z
          # @group.scale.set @options.scale
          @group.scale.x = @group.scale.y = @group.scale.z = math.mean [@options.scale.x = @options.scale.y = @options.scale.z]
          # @group.scale.x = @options.scale.x
          # @group.scale.y = @options.scale.y
          # @group.scale.z = @options.scale.z
          # @group.rotation.x += x * 0.1
          # @group.rotation.y -= y * 0.1
          # @group.scale.x += deltaCalc
          # @group.scale.y -= deltaCalc
          # console.log "x: #{x}, y: #{y}, deltaCalc: #{deltaCalc}"
        interactive: true
    }
  ], () ->
    SiteEvent.emit 'layout', { template: 'particles', state: 'rendered' }
