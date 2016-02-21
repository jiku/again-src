import React from 'react';
import {mount} from 'react-mounter';

import MainLayout from './components/main_layout.jsx';
import Sections from './containers/sections';

export default function (injectDeps, {FlowRouter}) {
  const MainLayoutCtx = injectDeps(MainLayout);

  // TODO: Should <Sections> setup and route (/) be here?

  FlowRouter.route('/:section', {
    name: 'section',
    action({section}) {
      mount(MainLayoutCtx, {
        content: () => (<Sections section={section}/>) // TODO: Should just send data to <Sections>, not re-render
      });
    }
  });
}
