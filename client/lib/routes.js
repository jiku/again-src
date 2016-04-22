import {BlazeLayout} from 'meteor/kadira:blaze-layout';
import {FlowRouter} from 'meteor/kadira:flow-router';
// import {Soundplayer} from '/imports/modules/Soundplayer/client/Soundplayer.jsx';
import {SiteEvent} from '/client/events.coffee';
import Data from '/client/data.coffee';

FlowRouter.wait();

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
  // reactComponent: function() { return Soundplayer; },
  action: function(params, queryParams) {
    render();
  }
});

FlowRouter.route('/:scrollTo', {
  name: 'home_scroll',
  reactComponent: function() { return Soundplayer; },
  triggersEnter: [
    function(context, redirect) {
      if (!_.contains(Data.site.sections, context.path.split('/')[1])) {
        redirect('/');
      }
    }
  ],
  action: function(params, queryParams) {
    if (_.isEmpty(Data.site.lastPath) && (_.contains(Data.site.sections, params.scrollTo))) {
      Data.site.externalDirect = true;
      render();
    }
  }
});

var setLastPath = function(context, redirect, stop) {
  Data.site.lastPath = context.path.split('/')[1];
};

FlowRouter.triggers.exit([setLastPath]);

FlowRouter.initialize();
