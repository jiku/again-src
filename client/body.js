SoundEvent = new EventEmitter();
SiteEvent = new EventEmitter();

marked.setOptions({
  breaks: true
});

Meteor.startup(function() {
  Session.setDefault("state", "init");
  Session.setDefault("statePixiJS", "unready");
  Session.setDefault("stateThreeJS", "unready");
  Session.setDefault("stateSoundCloud", "unready");
controller.scrollTo(function(target) {

  TweenMax.to(window, 0.5, {
    scrollTo : {
      y : target, // scroll position of the target along y axis
      autoKill : true // allows user to kill scroll action smoothly
    },
    ease : Cubic.easeInOut
  });
});

//  Bind scroll to anchor links
$(document).on("click", "a[href^=#]", function(e) {
  var id = $(this).attr("href");

  if($(id).length > 0) {
    e.preventDefault();

    // trigger scroll
    controller.scrollTo(id);

    // If supported by the browser we can also update the URL
    if (window.history && window.history.pushState) {
      history.pushState("", document.title, id);
    }
  }
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
