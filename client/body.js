SoundEvent = new EventEmitter();
SiteEvent = new EventEmitter();

Meteor.startup(function() {
  Session.setDefault("state", "init");
  Session.setDefault("statePixiJS", "unready");
  Session.setDefault("stateThreeJS", "unready");
  Session.setDefault("stateSoundCloud", "unready");
});

Template.body.onCreated = Template.body.created = function(){

  var onComponentState = function(data) { // Set in the component itself...
    Session.set("state" + data.component, data.state);

    if (Session.equals("state", "init") && Session.equals("statePixiJS", "ready") && Session.equals("stateThreeJS", "ready") && Session.equals("stateSoundCloud", "ready")) {
      Session.set("state", "intro");
    }
  };

  SiteEvent.on('componentState', onComponentState);
}
