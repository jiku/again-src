import React from 'react';
import {slide as SlidingMenu} from 'react-burger-menu';
import Radium from 'radium';
// import color from 'color';
import MtSvgLines from 'react-mt-svg-lines';
import Icon from './icon.jsx';
// import SvgSpinner from '/again/SvgSpinner.svg';

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

// const BurgerIcon = () => (
//   // <MtSvgLines animate={ true } duration={ 5000 }>
//   <MtSvgLines animate={ triggerSpinnerAnim } duration={ 1500 } stagger={ 20 } timing="linear" playback="2 alternate-reverse both">
//     <svg viewBox="0 0 100 100" width="100" height="100">
//       <g fill="none" strokeWidth="8" strokeMiterlimit="10" strokeLinecap="round">
//         <path stroke="#444" d="M50 95C25.1 95 5 74.9 5 50S25.1 5 50 5s45 20.1 45 45c0 24.8-20.3 45-45 45"/>
//         <path stroke="#777" d="M50 85c-19.3 0-35-15.7-35-35s15.7-35 35-35 35 15.7 35 35-15.8 35-35 35"/>
//         <path stroke="#aaa" d="M50 75c-13.8 0-25-11.2-25-25s11.2-25 25-25 25 11.2 25 25-11.3 25-25 25"/>
//         <path stroke="#eee" d="M50 65c-8.3 0-15-6.7-15-15s6.7-15 15-15 15 6.7 15 15c0 8.2-6.8 14.9-15 15"/>
//       </g>
//     </svg>
//   </MtSvgLines>
// );

let Example = React.createClass({
  render: () => {
    return (
      <SlidingMenu placement='bottom' burgerBoy={ () => <Icon /> } >
      {/*<SlidingMenu placement='bottom' burgerBoy={ BurgerIcon }>*/}
        <a key="0" id="header" href="/again/header"><i className="fa fa-arrow-up"></i></a>
        <a key="1" id="home" href="/again/about">About</a>
        <a key="2" id="about" href="/again/player">Player</a>
        <a key="3" id="contact" href="/again/contact">Contact</a>
        <a key="4" id="footer" href="/again/footer"><i className="fa fa-arrow-down"></i></a>
      </SlidingMenu>
    );
  }
});

Example = Radium(Example);

const Menu = ({}) => (
  <div className='menu'>
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
