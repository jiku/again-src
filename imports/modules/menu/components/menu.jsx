import React from 'react';
import {slide as SlidingMenu} from 'react-burger-menu';
import Radium from 'radium';
import color from 'color';

// import MenuItem from './MenuItem.jsx';
// import * as BTMenu from 'meteor/qazuor:animated-border-menu';

// const Menu = ({}) => (
//   <div className='menu'>
//     <Menu />
//     // TODO: Should contain all the different men items, programmatically added...
//   </div>
// );

// import withStyles from 'isomorphic-style-loader/lib/withStyles';
// import s from './Menu.scss';

// let ;
// <div className={ this.props.side }>

// let Menu = (SlidingMenu = Radium(BurgerMenu.slide)) => (
// @Radium

// let Menu = ({}) => (
    // <SlidingMenu id="slide" pageWrapId={ "page-wrap" } outerContainerId={ "outer-container" } left>
    // </SlidingMenu>
// );

// let SlidingMenu = BurgerMenu.slide

let Example = React.createClass({
  showSettings: function(event) {
    event.preventDefault();
  },
  render: function() {
    return (
      <SlidingMenu styles={styles}>
        <a key="0" id="home" href="/" style="color: white;"><i className="fa fa-fw fa-star-o"></i>Home</a>
        <a key="1" id="about" href="/about" style={styles2.base}>About</a>
        <a key="2" id="contact" href="/contact" style={styles2.base}>Contact</a>
        <a key="3" onClick={ this.showSettings } href="/Settings" style={styles2.base}>Settings</a>
      </SlidingMenu>
    );
  }
});

Example = Radium(Example);

const Menu = ({}) => (
  <div className='player'>
    <Example />
  </div>
);

let styles = {
  bmBurgerButton: {
    position: 'fixed',
    width: '36px',
    height: '30px',
    left: '36px',
    top: '36px'
  },
  bmBurgerBars: {
    background: '#373a47'
  },
  bmCrossButton: {
    height: '24px',
    width: '24px'
  },
  bmCross: {
    background: '#bdc3c7'
  },
  bmMenu: {
    background: '#373a47',
    padding: '2.5em 1.5em 0',
    fontSize: '1.15em'
  },
  bmMorphShape: {
    fill: '#373a47'
  },
  bmItemList: {
    color: '#b8b7ad',
    padding: '0.8em'
  },
  bmOverlay: {
    background: 'rgba(0, 0, 0, 0.3)'
  }
};

let styles2 = {
  base: {
    color: '#eee',
    ':hover': {
      background: color('#97f').lighten(0.2).hexString()
    }
  }
};

console.log(Menu);
// Menu = Radium(Menu)
// console.log(Menu);

export default Menu;
