import {createApp} from 'mantra-core';
import initContext from './configs/context';

// modules
import coreModule from '/imports/modules/core';
import menuModule from '/imports/modules/menu';
import playerModule from '/imports/modules/player';

// init context
const context = initContext();

// create app
const app = createApp(context);
app.loadModule(coreModule);
app.loadModule(menuModule);
app.loadModule(playerModule);
app.init();
