import React from 'react';
import Navigation from './navigation.jsx';
import Menu from '../../menu/containers/menu.js';
import MtSvgLines from 'react-mt-svg-lines';
// import SvgSpinner from './SvgSpinner.js';

const Layout = ({content = () => null }) => (
  <div>
    <div>
      <sections>
        <section className="box">
          <header>Again</header>
          <Navigation />
        </section>
        <section className="box">
          <div>
          {content()}
          </div>
        </section>
        <section className="box">
          <footer>
          <small>Built with <a href='https://github.com/kadirahq/mantra'>Mantra</a> &amp; Meteor.</small>
          </footer>
        </section>
      </sections>
    </div>
    <div>
      <Menu />
    </div>
  </div>
);

export default Layout;
