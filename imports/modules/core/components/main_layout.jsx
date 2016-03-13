import React from 'react';
import Navigation from './navigation.jsx';
import Menu from '../../menu/containers/menu.js';

const Layout = ({content = () => null }) => (
  <div>
    <div>
      <header>
      jiku - «Again»
      <Navigation />
      </header>

      <div>
      {content()}
      </div>

      <footer>
      <small>Built with <a href='https://github.com/kadirahq/mantra'>Mantra</a> &amp; Meteor.</small>
      </footer>
    </div>
    <div>
      <Menu />
    </div>
  </div>
);

export default Layout;
