  SoundEvent = new EventEmitter();
Meteor.startup(function() {
  Session.setDefault("state", "intro");
});

