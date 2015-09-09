Template.pane.onCreated = Template.pane.created = function() {
}

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
  var julia2OffsetY = 150;
  var fog1 = undefined;
  var fog2 = undefined;
  var fog3 = undefined;
  var scrolling = false;

  var loader = PIXI.loader;
  loader.add('Julia3Atest2400x', '/1B2_long_title_2400p_mq.jpg')
  .add('Julia3Atest2400xCosmic', '/Julia3Atest2400xCosmic.jpg')
  .add('fog1', '/fog1.jpg')
  .add('fog2', '/smoke-texture-png-wallpaper-1.jpg')
  .add('fog3', '/smoke-cloud-texture-wallpaper-2.jpg')
  .once('complete', function(loader, resources) { init(); })
  .load();

  var active = false;
  var interactive = false;
  // var interactivityType = "move";
  var interactivityType = "scroll"; // "scrollByPercentage";

  var init = function()
  {
    julia2 = new PIXI.Sprite(loader.resources['Julia3Atest2400x'].texture);
    julia2.name = "julia2";
    julia2.position.y = julia2OffsetY;
    julia2.alpha = 1;
    julia2.interactive = true;
    stage.addChild(julia2);

    cosmic = new PIXI.Sprite(loader.resources['Julia3Atest2400xCosmic'].texture);
    cosmic.name = "cosmic";
    cosmic.blendMode = PIXI.BLEND_MODES.SCREEN;
    cosmic.alpha = 1;
    cosmic.interactive = true;
    stage.addChild(cosmic);

    SiteEvent.emit('componentState', { component: "PixiJS", state: "ready" });
    SiteEvent.on('activate', onActivate);
  };

  var onActivate = function(event)
  {
    resize();

    animate();

    tweenTo(stage, { type: "fadeIn", time: 5 });

    active = true;
  }

  var resize = function (event) {
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

    sprite.heightRatio = valueRatio(renderer.height, sprite.height);
  }

  var tweenTo = function (target, data) {
    if (data.type == "fadeIn") {
      target.alpha = 0;
      target.visible = true;
      properties = { alpha: 1 };
      easingType = TWEEN.Easing.Quadratic.Out;
      cb = enableInteractivity;
    }
    new TWEEN.Tween(target)
    .to(properties, data.time * 1000)
    .easing(easingType)
    .onComplete(cb)
    .start();
  }

  var onScroll = function(event) {
    for (var i = 0; i < stage.children.length; i++ ) {
      moveByPercentage(stage.children[i], stage.children[i].heightRatio, event);
    }
  }

  var disableInteractivity = function () {
    if (interactive) {
      interactive = false;
      console.log("Disabled interactive");
      if (interactivityType = "scroll") {
      } else if (interactivityType == "move") {
        for (var i = 0; i < stage.children.length; i++ ) {
          stage.children[i].removeListener('mousemove').removeListener('touchmove');
        }
      }
    }
  }
  var enableInteractivity = function () {
    if (!interactive) {
      interactive = true;
      console.log("Enabled interactive");
      if (interactivityType = "scroll") {
      } else if (interactivityType == "move") {
        for (var i = 0; i < stage.children.length; i++ ) {
          stage.children[i].on('mousemove', onMove).on('touchmove', onMove);
        }
      }
    }
  }

  window.addEventListener('resize', resize);
  window.addEventListener('deviceOrientation', resize);

  function valueRatio(absoluteValue, relativeValue) {
    return (relativeValue - absoluteValue) / absoluteValue;
  }
  function valueChange(absoluteValue, relativeValue, valueRatio) {
    return (absoluteValue * valueRatio) + relativeValue;
  }

  function moveByPercentage(target, valueRatio, percentage) {
    var yChange = valueChange((window.innerHeight * percentage), target.position.y, valueRatio);
    target.position.y = (target.position.y + julia2OffsetY) - yChange;
  }

  function moveTo(target, valueRatio, coordinates) {
    var yChange = valueChange(coordinates.y, target.position.y, valueRatio);
    target.position.y -= yChange;
  }

  function onMove(event){
    moveTo(event.target, event.target.heightRatio, event.data.global);
  }

  $(window).scroll(function() { scrolling = true });

  function animate(time) {
    requestAnimationFrame(animate);
    if (scrolling) {
      scrolling = false;
      onScroll(($(window).scrollTop() + $(window).height()) / $(document).outerHeight());
    }
    TWEEN.update(time);
    renderer.render(stage);
  }
}
