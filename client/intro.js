Template.intro.rendered = function(){
  $(event.currentTarget).addClass('fadein');
};

Template.intro.events({
  'click': function (event) {
    if (Session.equals("state", "intro")) {
      Session.set("state", "normal");
      SoundEvent.emit('play', {
        data: "Play «Priss»."
      });
    }
  }
});
