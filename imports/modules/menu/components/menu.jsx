import React from 'react';
import {slide as SlidingMenu} from 'react-burger-menu';
import Radium from 'radium';
import color from 'color';
// import Styles from 'react-burger-menu.styl';

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
  toggleMenu: function(event) {
    event.preventDefault();
    console.log("yay");
    this.state.isOpen;
  },
  render: function() {
    return (
      // <SlidingMenu styles={styles} placement='bottom'>
      <SlidingMenu placement='bottom'>
        <a key="0" onClick={ this.toggleMenu } id="header" href="/again/header"><i className="fa fa-fw fa-arrow-up"></i></a>
        <a key="1" onClick={ this.toggleMenu } id="home" href="/again/about">About</a>
        <a key="2" onClick={ this.toggleMenu } id="about" href="/again/player">Player</a>
        <a key="3" onClick={ this.toggleMenu } id="about" href="/again/contribute">Contribute</a>
        <a key="4" onClick={ this.toggleMenu } id="contact" href="/again/contact">Contact</a>
        <a key="5" onClick={ this.toggleMenu } id="footer" href="/again/footer"><i className="fa fa-fw fa-arrow-down"></i></a>
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

// let styles = {
//   bmBurgerButton: {
//     position: 'fixed',
//     width: '36px',
//     height: '30px',
//     left: '50%',
//     bottom: '36px'
//   },
//   bmBurgerBars: {
//     background: '#97f'
//   },
//   bmCrossButton: {
//     height: '24px',
//     width: '24px'
//   },
//   bmCross: {
//     background: '#bdc3c7'
//   },
//   bmMenu: {
//     background: '#000',
//     fontSize: '1.15em',
//     display: 'flex',
//     'align-items': 'center'
//   },
//   bmMorphShape: {
//     fill: '#373a47'
//   },
//   bmItemList: {
//     color: '#b8b7ad',
//     display: 'flex',
//     'font-family': 'jikutypeVector',
//     'text-decoration': 'none',
//     'text-transform': 'lowercase',
//     'font-size': '4px',
//     'flex-flow': 'row',
//     'flex-direction': 'row',
//     'justify-content': 'center',
//     'align-items': 'center'
//   },
//   bmOverlay: {
//     background: 'rgba(0, 0, 0, 0.3)'
//   },
// };

// let styles2 = {
// };

console.log(Menu);
// Menu = Radium(Menu)
// console.log(Menu);

export default Menu;
