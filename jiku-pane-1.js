if (Meteor.isClient) {
  Template.pane.rendered = function(){
    var renderer = new PIXI.WebGLRenderer(960, 480);
    document.getElementById('pane').appendChild(renderer.view);
    var stage = new PIXI.Container();
    var texture = PIXI.Texture.fromImage('http://i.imgur.com/3akVAln.jpg');
    var sprite = new PIXI.Sprite(texture);

    sprite.anchor.x = sprite.anchor.y = 0;
    // sprite.anchor.x = sprite.anchor.y = 0.5;
    sprite.position.x = sprite.position.y = 0;
    sprite.scale.x = sprite.scale.y = 1;

    sprite.interactive = true;
    sprite.on('mousemove', onMove).on('touchmove', onMove);

    var active = true;

    var resize = function () {
      spriteResize();
    };

    var spriteResize = function() {
      spriteRatio = sprite.width / sprite.height;
      spriteMaxWidth = window.innerWidth;
      spriteMaxHeight = window.innerHeight;
      windowRatio = window.innerWidth / window.innerHeight;

      windowRatio >= spriteRatio ? (sprite.width = spriteMaxWidth, sprite.height = spriteMaxWidth / spriteRatio) : (sprite.height = spriteMaxHeight, sprite.width = spriteMaxHeight * spriteRatio);

      renderer.resize(window.innerWidth, window.innerHeight);
    }

    };

    // Add listeners for canvas scaling with window resizing and device rotation
    window.addEventListener('resize', resize);
    window.addEventListener('deviceOrientation', resize);
    resize(); // Initial call...

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

    stage.addChild(sprite);

    animate();
    function animate() {
      requestAnimationFrame(animate);
      renderer.render(stage);
    }
  }
}
