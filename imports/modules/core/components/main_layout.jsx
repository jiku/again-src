import React from 'react';
import Navigation from './navigation.jsx';

const Layout = ({content = () => null }) => (
  <div>
    <header>
    <h1>jiku - «Again»</h1>
    <Navigation />
    </header>

    <div>
    {content()}
    </div>

    <footer>
    <small>Built with <a href='https://github.com/kadirahq/mantra'>Mantra</a> &amp; Meteor.</small>
    </footer>
  </div>
);

export default Layout;
