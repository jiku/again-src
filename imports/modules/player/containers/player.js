import Player from '../components/player.jsx';
import {useDeps, composeWithTracker, composeAll} from 'mantra-core';

export const composer = ({context}, onData) => {
  const {} = context();
  onData(null, {});
};

export default composeAll(
  composeWithTracker(composer),
  useDeps()
)(Player);
