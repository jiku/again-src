Template.pane.rendered = function(){
  var renderer = PIXI.autoDetectRenderer(960, 480,{backgroundColor : 0x000000});
  document.getElementById('pane').appendChild(renderer.view);
  var stage = new PIXI.Container();
  var texture = undefined;

  var loader = PIXI.loader;
  loader.add('Julia3Atest2', '/Julia3Atest2.jpg');
  loader.add('fog1', '/fog1.jpg');
  loader.add('fog2', '/smoke-texture-png-wallpaper-1.jpg');
  loader.add('fog3', '/smoke-texture-png-wallpaper-1.jpg');
  loader.once('complete', function(loader, resources) { init(); });
  loader.load();

  var active = false;

  var init = function()
  {
    var julia2 = new PIXI.Sprite(loader.resources['Julia3Atest2'].texture);
    spriteResize(julia2);
    julia2.interactive = true;
    julia2.on('mousemove', onMove).on('touchmove', onMove);
    stage.addChild(julia2);

    var fog1 = new PIXI.Sprite(loader.resources['fog1'].texture);
    spriteResize(fog1)
    fog1.blendMode = PIXI.BLEND_MODES.SCREEN;
    fog1.alpha = 0.1;
    fog1.interactive = true;
    fog1.on('mousemove', onMove).on('touchmove', onMove);
    stage.addChild(fog1);

    var fog2 = new PIXI.Sprite(loader.resources['fog2'].texture);
    spriteResize(fog2)
    fog2.blendMode = PIXI.BLEND_MODES.SCREEN;
    fog2.alpha = 0.3;
    fog2.interactive = true;
    fog2.on('mousemove', onMove).on('touchmove', onMove);
    stage.addChild(fog2);

    var fog3 = new PIXI.Sprite(loader.resources['fog3'].texture);
    spriteResize(fog3)
    fog3.blendMode = PIXI.BLEND_MODES.SCREEN;
    fog3.alpha = 0.5;
    fog3.interactive = true;
    fog3.on('mousemove', onMove).on('touchmove', onMove);
    stage.addChild(fog3);

    resizeRenderer();

    active = true;
  };

  var resize = function (event) { // onResize... i.e. event...
    spriteResize(event.target);
    resizeRenderer();
  };

  var spriteResize = function(sprite) {
    spriteRatio = sprite.width / sprite.height;
    spriteMaxWidth = window.innerWidth;
    spriteMaxHeight = window.innerHeight;
    windowRatio = window.innerWidth / window.innerHeight;

    if (windowRatio >= spriteRatio)
    {
      sprite.width = spriteMaxWidth;
      sprite.height = spriteMaxWidth / spriteRatio;
    } else {
      sprite.height = spriteMaxHeight;
      sprite.width = spriteMaxHeight * spriteRatio;
    }
  }

  var resizeRenderer = function() {
    renderer.resize(window.innerWidth, window.innerHeight);
  }

  window.addEventListener('resize', resize);
  window.addEventListener('deviceOrientation', resize);

  function onMove(event){
    var local = event.target; // this
    var global = event.data.global;

    viewportAbsoluteTop = 0;
    viewportAbsoluteBottom = renderer.height;

    if (active && global.y > viewportAbsoluteTop && global.y < viewportAbsoluteBottom) {
      var yRatio = (this.height - renderer.height) / renderer.height; // *height* stuff not really doing anything?... Find and use ratio of content to viewport (renderer? stage?)...
      var yChange = (global.y * yRatio) + this.position.y; // Subtracts?
      this.position.y -= yChange; // Toggle between += and -= based on?
    }
  }

  animate();
  function animate() {
    requestAnimationFrame(animate);
    renderer.render(stage);
  }
}
