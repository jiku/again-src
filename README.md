# again-src

[![Stories in Ready](https://badge.waffle.io/jiku/again-src.png?label=ready&title=Ready)](http://waffle.io/jiku/again-src)

# BRANCH STATUS

## Issues with `cosmos:browserify`, `react-runtime-dev`, etc.

```
=> Errors prevented startup:

   While processing files with cosmos:browserify (for target web.browser):
   packages/react-runtime-dev/react.browserify.js: Cannot call method 'slice' of undefined

   While minifying app stylesheet:
   error: Can't load npm module 'autoprefixer' from packages/minifier-postcss_plugin.js. Check your Npm.depends().

   While processing files with cosmos:browserify (for target os.osx.x86_64):
   packages/react-runtime-dev/react.browserify.js: Cannot call method 'slice' of undefined
```

---

There are some issues here with just getting it to start. Maybe with using Meteor 1.3b11 and Meteor-Webpack (which hasn't been updated yet).

See

[tomitrescak/Meteor-Boilerplate-Webpack-Mantra-Typescript: Meteor boilerplate for mantra applications, supporting webpack, mantra and typescript](https://github.com/tomitrescak/Meteor-Boilerplate-Webpack-Mantra-Typescript)

where `webpack.packages.json` is used ahead of `package.json` and Mantra is in modules/Mantra rather than / (/client and /imports for lazy-loaded modules).

and

[Pros and cons of using webpack with Meteor / mantra · Issue #1 · tomitrescak/Meteor-Boilerplate-Webpack-Mantra-Typescript](https://github.com/tomitrescak/Meteor-Boilerplate-Webpack-Mantra-Typescript/issues/1)

Then

[thereactivestack/meteor-webpack: Meteor package for Webpack](https://github.com/thereactivestack/meteor-webpack)

This is what's stopping it for now

```shell
=> Errors prevented startup:

   While processing files with webpack:webpack (for target os.osx.x86_64):
   entry/server/webpack.conf.js: ./entry/server/entry.js
   Module build failed: ReferenceError: [BABEL] /Volumes/Data/Dev/Projects/jiku/Again/app/src/entry/server/entry.js: Unknown option: /Volumes/Data/Dev/Projects/jiku/Again/app/src/.babelrc.presets
   at Logger.error (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/logger.js:58:11)
   at OptionManager.mergeOptions (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/options/option-manager.js:126:29)
   at OptionManager.addConfig (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/options/option-manager.js:107:10)
   at OptionManager.findConfigs (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/options/option-manager.js:168:35)
   at OptionManager.init (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/options/option-manager.js:229:12)
   at File.initOptions (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/index.js:147:75)
   at new File (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/file/index.js:137:22)
   at Pipeline.transform (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-core/lib/transformation/pipeline.js:164:16)
   at transpile (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-loader/index.js:12:22)
   at Object.module.exports (/Volumes/Data/Dev/Projects/jiku/Again/app/src/.meteor/local/webpack-npm/node_modules/babel-loader/index.js:69:12)

=> Your application has errors. Waiting for file change.
```
