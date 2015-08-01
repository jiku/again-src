if (Meteor.isClient) {
  Template.pane.rendered = function(){
    var renderer = new PIXI.WebGLRenderer(960, 480);
    document.getElementById('pane').appendChild(renderer.view);
    var stage = new PIXI.Container();
    var texture = undefined;
    var sprite = undefined;

    var loader = PIXI.loader;
    loader.add('skyscraper', 'http://i.imgur.com/3akVAln.jpg');
    loader.add('legs', 'http://i.imgur.com/pZOZu06.jpg');
    loader.once('complete', function(loader, resources) { init(); });
    loader.load();

    var active = false;

    var init = function()
    {
      texture = loader.resources['legs'].texture;
      sprite = new PIXI.Sprite(texture);

      sprite.anchor.x = sprite.anchor.y = 0;
      sprite.position.x = sprite.position.y = 0;
      sprite.scale.x = sprite.scale.y = 1;

      sprite.interactive = true;
      sprite.on('mousemove', onMove).on('touchmove', onMove);

      resize();
      stage.addChild(sprite);

      active = true;
    };

    var resize = function () {
      spriteResize();
    };

    var spriteResize = function() {
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

      renderer.resize(window.innerWidth, window.innerHeight);
    }

    };

    window.addEventListener('resize', resize);
    window.addEventListener('deviceOrientation', resize);

    function onMove(event){
      var local = event.target; // this
      var global = event.data.global;

      viewportAbsoluteTop = 0;
      viewportAbsoluteBottom = renderer.height;

      if (active && global.y > viewportAbsoluteTop && global.y < viewportAbsoluteBottom) {
        var yRatio = (this.height - renderer.height) / renderer.height; // *height* stuff not really doing anything?... Find and use ratio of content to viewport (renderer? stage?)...
        // console.log("renderer to sprite yRatio", yRatio);
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
}
