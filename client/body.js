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
  Session.setDefault("componentStates", []);
});

controller = new ScrollMagic.Controller();
controller.scrollTo(function(target, time) {
  if (time === undefined) {
    time = 0.5;
  }
  TweenMax.to(window, time, {
    scrollTo: {
      y: target,
      autoKill: true
    },
    ease: Cubic.easeInOut
  });
});

$(document).on("click", "a[href^=#]", function(e) {
  var id = $(this).attr("href");

  if($(id).length > 0) {
    e.preventDefault();
    controller.scrollTo(id);
  }
});

Template.body.onCreated = Template.body.created = function(){
  var onComponentState = function(data) {
    Session.set("state" + data.component, data.state);

    if (Session.equals("state", "init") && Session.equals("statePixiJS", "ready") && Session.equals("stateThreeJS", "ready") && Session.equals("stateSoundCloud", "ready")) {
      Session.set("state", "intro");
    }
  };

  SiteEvent.on('componentState', onComponentState);
}

Template.body.onRendered = Template.body.rendered = function() {
  var sections = []
  if (Session.get('isProdEnvironment')) {
    sections = ["top", "about", "player", "credits", "contribute", "contact", "copyright", "bottom"];
  } else {
    sections = ["top", "about", "player", "crappycrap", "credits", "contribute", "contact", "copyright", "bottom"];
  }

  for (var i = 0; i < sections.length; i++)
  {
    var name = "SECTION " + sections[i];
    var section = new ScrollMagic.Scene({
      triggerElement: 'section#' + sections[i],
      slider: 'right'
    })
    .setClassToggle('a#' + sections[i], "active")
    .setTween(TweenMax.to('section#' + sections[i], 1, { transform: 'opacity(1)', ease: Linear.easeNone }))
    .addTo(controller);

    if (Session.get('isProdEnvironment')) {
      section.addIndicators({ name: name });
    }
  }

  var toggleScroll = function(selector, state)
  {
    var target = $(selector);

    if (state == "toggle" && target.hasClass('disable-scroll')) {
      state = "off";
    } else {
      state = "on";
    }

    if (state == "on") {
      target.removeClass('disable-scroll');
    } else if (state == "off") {
      subsection.addClass('disable-scroll');
    }
  }

  var toggleSubSection = function(selector, state)
  {
    var target = $(selector);

    if (state == "toggle" && target.hasClass('visible')) {
      state = "off";
    } else {
      state = "on";
    }

    if (state == "on") {
      target.addClass('fadein')
      .removeClass('invisible')
      .addClass('visible')
      .removeClass('disable-clicks')
      .removeClass('disable-selection');
    } else if (state == "off") {
      target.addClass('fadeout')
      .removeClass('visible')
      .addClass('invisible')
      .addClass('disable-clicks')
      .addClass('disable-selection');
    }
  }

  var toggleFixedMenu = function(selector, state)
  {
    var target = $(selector);

    if (state == "on") {
      target.addClass('fadein')
      .removeClass('invisible')
      .addClass('visible')
      .removeClass('disable-clicks')
      .removeClass('disable-selection');
    } else if (state == "off") {
      target.addClass('fadeout')
      .removeClass('visible')
      .addClass('invisible')
      .addClass('disable-clicks')
      .addClass('disable-selection');
    }
  }

  var onActivate = function(event)
  {
    controller.scrollTo($(window).height() + $(document).outerHeight(), 6);

    toggleScroll("body", "on");
    toggleSubSection("subsection", "on");
    toggleFixedMenu("fixedMenu", "on");
  }

  SiteEvent.on('activate', onActivate);
}
