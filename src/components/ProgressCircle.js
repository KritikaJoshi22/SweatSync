import React from 'react'
import { CircularProgressbar, buildStyles } from 'react-circular-progressbar';
import 'react-circular-progressbar/dist/styles.css';



function ProgressCircle({}) {
  const percentage=75;
    return (
      <div className=''>
      <CircularProgressbar value={percentage} text={`${percentage}%`}
      styles={buildStyles({pathColor: `rgba(62, 152, 199, ${percentage / 100})`,
      textColor: '#f8888',
      trailColor: '#d6d6d6',
      backgroundColor: '#1e98c7',
      })}/>
      </div>
    );
}

export default ProgressCircle

