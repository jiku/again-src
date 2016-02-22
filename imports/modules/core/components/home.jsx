import React from 'react';
// import PlaylistSoundPlayer from '../../player/components/Soundplayer/client/Soundplayer.jsx'; // TODO: This should be a complete module?
import Menu from '../../menu/containers/menu.js';
import Player from '../../player/containers/player.js';

const Home = ({}) => (
  <div className='home'>
    Base sections
    <div>
      <h4>Player</h4>
      <Player postId={'yo'}/>
    </div>
    <div>
      <Menu />
    </div>
  </div>
);

export default Home;
