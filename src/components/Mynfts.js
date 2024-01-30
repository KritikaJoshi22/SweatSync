import React, { useEffect, useState } from 'react'
import { setGlobalState } from '../store'

// w-80 h-44 bg-gray-800 bg-opacity-50 shadow-xl flex rounded-lg overflow-hidden m-3 p-3
function Mynfts() {
  return (
    <div className='mt-7'>      
      <div className='py-8 w-4/5 mx-auto bg-opacity-50 bg-shadow-xl bg-gray-800 rounded-lg'>
        <h4 className='text-3xl font-bold uppercase interest ml-4 mx-auto'>My NFTs</h4>

        <div className='flex flex-wrap justify-center items-center mt-4'>
          {Array(4).fill().map((i)=>(
            <Card key={i}/>
          ))}
        </div>

      </div>
    </div>
  )
}
 
const Card=({nft})=>{
  return(
    <div className='w-50 h-60  bg-gray-800 shadow-xl shadow-black rounded-lg overflow-hidden m-3'>
      <div className='shadow-lg shadow-black rounded-lg mb-3'>
      <img
      src={'https://i.seadn.io/s/raw/files/5c69e6c837fb8f5dfce8cec02a629331.png?auto=format&dpr=1&w=1000'}
      alt={''} 
      className='object-cover w-full h-44 rounded-sm'
      />
      </div>

      <div>
      <h4 className='text-white font-semibold p-2'>title</h4>
      </div>
    </div>
  )
}

export default Mynfts