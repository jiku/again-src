import Soundplayer from 'Soundplayer/client/Soundplayer';

var render = function(args) {
  BlazeLayout.render('layoutNormal', {
    pane: 'pane',
    particles: 'particles',
    sections: 'sections',
    menu: 'menu'
  });
};

FlowRouter.route('/', {
  name: 'home',
  reactComponent: function() { return Soundplayer; },
  action: function(params, queryParams) {
    render();
  }
});

FlowRouter.route('/:scrollTo', {
  name: 'home_scroll',
  reactComponent: function() { return Soundplayer; },
  triggersEnter: [
    function(context, redirect) {
      if (!_.contains(jiku.again.sections, context.path.split('/')[1])) {
        redirect('/');
      }
    }
  ],
  action: function(params, queryParams) {
    if (_.isEmpty(jiku.again.lastPath) && (_.contains(jiku.again.sections, params.scrollTo))) {
      jiku.again.externalDirect = true;
      render();
    }
  }
});

var setLastPath = function(context, redirect, stop) {
  jiku.again.lastPath = context.path.split('/')[1];
};

FlowRouter.triggers.exit([setLastPath]);

FlowRouter.initialize();
