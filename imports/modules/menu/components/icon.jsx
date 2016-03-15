import React from 'react';
import MtSvgLines from 'react-mt-svg-lines';
// import SvgSpinner from './SvgSpinner';

export default class Icon extends React.Component {
  constructor( props ) {
    super( props );

    this.state = {
      triggerSpinnerAnim: true
    };
  }

  render() {
    const { triggerSpinnerAnim } = this.state;

    return (
      <MtSvgLines animate={ triggerSpinnerAnim } duration={ 1500 } stagger={ 20 } timing="linear" playback="2 alternate-reverse both">
        {/*<SvgSpinner />*/}
        <a href="" data-trigger={ 'triggerSpinnerAnim' } onClick={ this._handleAnimateClick }>
          <svg viewBox="0 0 100 100" width="100" height="100" preserveAspectRatio="xMidYMin">
            <g fill="none" strokeWidth="8" strokeMiterlimit="10" strokeLinecap="round">
              <path stroke="#444" d="M50 95C25.1 95 5 74.9 5 50S25.1 5 50 5s45 20.1 45 45c0 24.8-20.3 45-45 45"/>
              <path stroke="#777" d="M50 85c-19.3 0-35-15.7-35-35s15.7-35 35-35 35 15.7 35 35-15.8 35-35 35"/>
              <path stroke="#aaa" d="M50 75c-13.8 0-25-11.2-25-25s11.2-25 25-25 25 11.2 25 25-11.3 25-25 25"/>
              <path stroke="#eee" d="M50 65c-8.3 0-15-6.7-15-15s6.7-15 15-15 15 6.7 15 15c0 8.2-6.8 14.9-15 15"/>
            </g>
          </svg>
        </a>
      </MtSvgLines>
    );
  }

  // when any "animate &raquo;" link is clicked, set the corresponding 'animate' prop to trigger it
  _handleAnimateClick( e ) {
    console.log("YOOYOO");
    // e.preventDefault();

    // Should only open the menu after it's done animating...

    const triggerKey = e.target.dataset.trigger; // determine which clicked from its data attr
    const triggerVal = String(Date.now()); // generate a unique string to pass to 'animate'

    this.setState({ [ triggerKey ]: triggerVal });
  }
}
