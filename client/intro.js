Template.intro.events({
  'click': function (event) {
    if (Session.equals("state", "intro")) {
      Session.set("state", "playing");

      SoundEvent.emit('play', {
        data: "Play «Priss»."
      });
    }
  }
});
