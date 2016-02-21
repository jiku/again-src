import React from 'react';

const Sections = ({sections}) => (
  <div className='sections'>
    <ul>
      {sections.map(section => (
        <section id={section.id}>
          <Section />
        </section>
      ))}
    </ul>
  </div>
);

export default Sections;
