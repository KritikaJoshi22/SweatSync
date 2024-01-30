import React from 'react'
import ProgressCircle from './ProgressCircle';

function Statbox() {

  return (
    <div className='mt-9 w-full flex justify-center items-center md:flex-row flex-col'>
      <div className='w-80 h-44 bg-gray-800 bg-opacity-50 shadow-xl flex rounded-lg overflow-hidden m-3 p-3'>
        <div className='flex flex-col justify-start m-4'>
          <h4 className='interest font-semibold'>Total Steps Taken</h4>
          <p className="text-white text-xs my-1 limit">12000</p>

          <h4 className='interest font-semibold'>Total Steps</h4>
          <p className="text-white text-xs my-1 limit">1200</p>
        </div>

        <div className='flex justify-between items-center ml-9 w-20'>
          <ProgressCircle />
        </div>
      </div>


      <div className='w-80 h-44 bg-gray-800 bg-opacity-50 shadow-xl flex rounded-lg overflow-hidden m-3 p-3'>
        <div className='flex flex-col justify-start m-4'>
          <h4 className='interest font-semibold'>Total Calories Burn</h4>
          <p className="text-white text-xs my-1 limit">12000</p>

          <h4 className='interest font-semibold'>Total Calories</h4>
          <p className="text-white text-xs my-1 limit">1200</p>
        </div>

        <div className='flex justify-between items-center ml-9 w-20'>
          <ProgressCircle />
        </div>
      </div>


      <div className='w-80 h-44 bg-gray-800 bg-opacity-50 shadow-xl flex rounded-lg overflow-hidden m-3 p-3'>
        <div className='flex flex-col justify-start m-4'>
          <h4 className='interest font-semibold'>Total Steps taken</h4>
          <p className="text-white text-xs my-1 limit">12000</p>

          <h4 className='interest font-semibold'>Total Steps</h4>
          <p className="text-white text-xs my-1 limit">1200</p>
        </div>

        <div className='flex justify-between items-center ml-9 w-20'>
          <ProgressCircle />
        </div>
      </div>

    </div>
  );
}

export default Statbox