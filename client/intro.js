Template.intro.events({
  'click': function (event) {
    if (Session.equals("state", "intro")) {
      $(event.currentTarget).addClass('fadeout');
      Session.set("state", "playing");

      SoundEvent.emit('play', {
        data: "Play «Priss»."
      });
    }
  }
});
