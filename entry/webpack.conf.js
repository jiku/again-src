var webpack = require('webpack');
var path = require('path');

module.exports = {
  externals: {
    // Use Meteor package for react(-dom), etc.
    'react': 'React',
    'react-dom': 'React.DOM',
    'react-addons-transition-group': 'React.addons.TransitionGroup',
    'react-addons-create-fragment': 'React.addons.createFragment',
    'react-addons-pure-render-mixin': 'React.addons.PureRenderMixin',
    'react-addons-update': 'React.addons.update',
    'react-addons-linked-state-mixin': 'React.addons.PureRenderMixin',
    'react-soundplayer': 'SoundPlayerContainer'
  },
  devServer: {
    host: 'localhost'
  },
  resolve: {
    root: path.join(__dirname, '..', 'modules'),
    extensions: ['', '.js', '.jsx', '.json', '.css']
  }
};
