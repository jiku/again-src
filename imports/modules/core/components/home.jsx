import React from 'react';

const Home = ({content = () => null }) => (
  <div>
    <header>
    <h1>Home then</h1>
    </header>

    <div>
    {content()}
    </div>
  </div>
);

export default Home;
