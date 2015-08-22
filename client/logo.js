Template.logo.rendered = function(){
  $(event.currentTarget).addClass('fadein');
};

Template.logo.events({
  'click': function (event) {
    if (Session.equals("state", "intro")) {
      Session.set("state", "normal");
      $(event.currentTarget).addClass('disable-clicks');
      SiteEvent.emit('activate', {});
      // if (Session.get('isProdEnvironment'))
      // {
        SoundEvent.emit('play', {
          data: "Play «Priss»."
        });
      // }
    }
  }
});