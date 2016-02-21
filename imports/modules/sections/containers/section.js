import Section from '../components/section.jsx';
import {useDeps, composeWithTracker, composeAll} from 'mantra-core';

export const composer = ({context, section}, onData) => {
  const {} = context();

  if (section) {
    onData(null, {section});
  } else {
    onData();
  }
};

export default composeAll(
  composeWithTracker(composer),
  useDeps()
)(Section);
