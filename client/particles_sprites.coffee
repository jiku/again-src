Template.particles.rendered = ->
  container = undefined
  # , stats;
  camera = undefined
  scene = undefined
  renderer = undefined
  particles = undefined
  geometry = undefined
  materials = []
  parameters = undefined
  i = undefined
  h = undefined
  color = undefined
  sprite = undefined
  size = undefined
  mouseX = 0
  mouseY = 0
  windowHalfX = window.innerWidth / 2
  windowHalfY = window.innerHeight / 2

  Detector.addGetWebGLMessage() if !Detector.webgl

  init = ->
    camera = new (THREE.PerspectiveCamera)(75, window.innerWidth / window.innerHeight, 1, 2000)
    camera.position.z = 1000
    scene = new (THREE.Scene)
    scene.fog = new (THREE.FogExp2)(0x000000, 0.0008)
    geometry = new (THREE.Geometry)
    sprite1 = THREE.ImageUtils.loadTexture('textures/sprites/snowflake7_alpha.png')
    sprite2 = THREE.ImageUtils.loadTexture('textures/sprites/snowflake7_alpha.png')
    sprite3 = THREE.ImageUtils.loadTexture('textures/sprites/snowflake7_alpha.png')
    sprite4 = THREE.ImageUtils.loadTexture('textures/sprites/snowflake7_alpha.png')
    sprite5 = THREE.ImageUtils.loadTexture('textures/sprites/snowflake7_alpha.png')
    i = 0
    while i < 1000
      vertex = new (THREE.Vector3)
      vertex.x = Math.random() * 2000 - 1000
      vertex.y = Math.random() * 2000 - 1000
      vertex.z = Math.random() * 2000 - 1000
      geometry.vertices.push vertex
      i++
    parameters = [
      [
        [
          1.0
          0.2
          0.5
        ]
        sprite2
        20
      ]
      [
        [
          0.95
          0.1
          0.5
        ]
        sprite3
        15
      ]
      [
        [
          0.90
          0.05
          0.5
        ]
        sprite1
        10
      ]
      [
        [
          0.85
          0
          0.5
        ]
        sprite5
        8
      ]
      [
        [
          0.80
          0
          0.5
        ]
        sprite4
        5
      ]
    ]
    i = 0
    while i < parameters.length
      color = parameters[i][0]
      sprite = parameters[i][1]
      size = parameters[i][2]
      materials[i] = new (THREE.PointCloudMaterial)(
        size: size
        map: sprite
        blending: THREE.AdditiveBlending
        depthTest: false
        transparent: true
        opacity: 0.5
        color: 0xFF0000)
      materials[i].color.setHSL color[0], color[1], color[2]
      particles = new (THREE.PointCloud)(geometry, materials[i])
      particles.rotation.x = Math.random() * 6
      particles.rotation.y = Math.random() * 6
      particles.rotation.z = Math.random() * 6
      scene.add particles
      i++
    renderer = new (THREE.WebGLRenderer)(
      clearAlpha: 1
      alpha: true)
    # var?
    renderer.setClearColor 0x000000, 0
    # the default
    renderer.setPixelRatio window.devicePixelRatio
    renderer.setSize window.innerWidth, window.innerHeight
    $('div#particles').append renderer.domElement
    document.addEventListener 'mousemove', onDocumentMouseMove, false
    document.addEventListener 'touchstart', onDocumentTouchStart, false
    document.addEventListener 'touchmove', onDocumentTouchMove, false
    window.addEventListener 'resize', onWindowResize, false
    SiteEvent.emit 'componentState',
      component: 'ThreeJS'
      state: 'ready'

  onWindowResize = ->
    windowHalfX = window.innerWidth / 2
    windowHalfY = window.innerHeight / 2
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize window.innerWidth, window.innerHeight

  onDocumentMouseMove = (event) ->
    mouseX = event.clientX - windowHalfX
    mouseY = event.clientY - windowHalfY

  onDocumentTouchStart = (event) ->
    if event.touches.length == 1
      mouseX = event.touches[0].pageX - windowHalfX
      mouseY = event.touches[0].pageY - windowHalfY

  onDocumentTouchMove = (event) ->
    if event.touches.length == 1
      mouseX = event.touches[0].pageX - windowHalfX
      mouseY = event.touches[0].pageY - windowHalfY

  animate = ->
    requestAnimationFrame animate
    render()

  render = ->
    time = Date.now() * 0.00005
    camera.position.x += (mouseX - camera.position.x) * 0.05
    camera.position.y += (-mouseY - camera.position.y) * 0.05
    camera.lookAt scene.position
    i = 0
    while i < scene.children.length
      object = scene.children[i]
      if object instanceof THREE.PointCloud
        object.rotation.y = time * (if i < 4 then i + 1 else -(i + 1))
      i++
    i = 0
    while i < materials.length
      color = parameters[i][0]
      h = 360 * (color[0] + time) % 360 / 360
      materials[i].color.setHSL h, color[1], color[2]
      i++
    renderer.render scene, camera

  init()
  animate()
