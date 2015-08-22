Template.pane.rendered = function(){
  var resizeRenderer = function() {
    renderer.resize(window.innerWidth, window.innerHeight);
  }

  var renderer = PIXI.autoDetectRenderer(960, 480,{backgroundColor : 0x000000});
  document.getElementById('pane').appendChild(renderer.view);
  var stage = new PIXI.Container();
  stage.visible = false;
  var texture = undefined;

  var julia2 = undefined;
  var fog1 = undefined;
  var fog2 = undefined;
  var fog3 = undefined;

  var loader = PIXI.loader;
  loader.add('Julia3Atest2', '/Julia3Atest2.jpg')
  .add('fog1', '/fog1.jpg')
  .add('fog2', '/smoke-texture-png-wallpaper-1.jpg')
  .add('fog3', '/smoke-cloud-texture-wallpaper-2.jpg')
  .once('complete', function(loader, resources) { init(); })
  .load();

  var active = false;

  var init = function()
  {
    julia2 = new PIXI.Sprite(loader.resources['Julia3Atest2'].texture);
    julia2.name = "julia2";
    julia2.alpha = 1;
    julia2.interactive = true;
    stage.addChild(julia2);

    fog1 = new PIXI.Sprite(loader.resources['fog1'].texture);
    fog1.name = "fog1";
    fog1.blendMode = PIXI.BLEND_MODES.SCREEN;
    fog1.alpha = 0.2;
    fog1.interactive = true;
    stage.addChild(fog1);

    fog2 = new PIXI.Sprite(loader.resources['fog2'].texture);
    fog2.name = "fog2";
    fog2.blendMode = PIXI.BLEND_MODES.SCREEN;
    fog2.alpha = 0.4;
    fog2.interactive = true;
    stage.addChild(fog2);

    fog3 = new PIXI.Sprite(loader.resources['fog3'].texture);
    fog3.name = "fog3";
    fog3.blendMode = PIXI.BLEND_MODES.SCREEN;
    fog3.alpha = 0.1;
    fog3.interactive = true;
    stage.addChild(fog3);

    fadeIn(stage);
    resize(); // Initial resize


    active = true;
    SiteEvent.emit('componentState', { component: "PixiJS", state: "ready" }); // Sure everything is loaded??
  };

  var resize = function (event) { // onResize... i.e. event...
    resizeRenderer();
    for (var i = 0; i < stage.children.length; i++ ) {
      spriteResize(stage.children[i]);
    }
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

    sprite.heightRatio = valueRatio(renderer.height, sprite.height); // VERY important to make other stuff... moveTo, etc, work...
  }

  var fadeIn = function (target) {
    target.alpha = 0;
    target.visible = true;
    new TWEEN.Tween(target)
    .to({ alpha: 1 }, 5000)
    .easing(TWEEN.Easing.Quadratic.Out) // See http://sole.github.io/tween.js/examples/03_graphs.html
    .onComplete(enableInteractivity)
    .start();
  }

  var enableInteractivity = function () { // Could have assets as list... changed with each state change... I.e. X1, X2, X3 in state Y1, X2, X3, X4 in state Y2.
    julia2.on('mousemove', onMove).on('touchmove', onMove);
    fog1.on('mousemove', onMove).on('touchmove', onMove);
    fog2.on('mousemove', onMove).on('touchmove', onMove);
    fog3.on('mousemove', onMove).on('touchmove', onMove);
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

  function animate(time) {
    requestAnimationFrame(animate);
    TWEEN.update(time);
    renderer.render(stage);
  }
}
