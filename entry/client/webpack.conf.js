var webpack = require('webpack');

var babelSettings = { stage: 0 };

module.exports = {
  entry: './entry',
  module: {
    loaders: [
      { test: /\.jsx?$/, loader: 'babel', query: babelSettings, exclude: /node_modules/ },
      // { test: /\.css$/, loader: 'style!css!style-loader!css-loader!cssnext-loader' },
      { test: /\.css$/, loader: 'style-loader!css-loader!cssnext-loader' },
      { test: /\.(png|jpe?g)(\?.*)?$/, loader: 'url?limit=8182' },
      { test: /\.(svg|ttf|woff|eot)(\?.*)?$/, loader: 'file' }
    ]
  }
};
