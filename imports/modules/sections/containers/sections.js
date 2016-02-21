import Sections from '../components/sections.jsx';
import {useDeps, composeWithTracker, composeAll} from 'mantra-core';

export const composer = ({context}, onData) => {
  const {Meteor} = context();
  if (Meteor.subscribe('posts.list').ready()) {
    onData(null, {});
  }
};

export default composeAll(
  composeWithTracker(composer),
  useDeps()
)(Sections);
