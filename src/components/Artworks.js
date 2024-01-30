import React, { useEffect, useState } from 'react'
import { setGlobalState } from '../store'

 
function Artworks() {
  return (
    <div className='w-full mt-8 flex flex-col justify-center items-center'>

      <div className='flex justify-start items-center ml-6 '>
        <p className='font-bold text-5xl md:text-6xl interest'>From sweat to NFTs,<br/> transform your hard work <br/> into digital art.</p>
      </div>
      
      <div className='py-10 mx-auto w-4/5 mt-4'>
        <h4 className='text-white text-3xl font-bold uppercase interest'>NFTs</h4>

        <div className='flex flex-wrap justify-center items-center mt-5'>
          {Array(6).fill().map((i)=>(
            <Card key={i}/>
          ))}
        </div>


        {/* {collection.length > 0 && nfts.length > collection.length ? (
          <div className="text-center my-5">
            <button
              className="shadow-xl shadow-black text-white
            bg-[#e32970] hover:bg-[#bd255f]
            rounded-full cursor-pointer p-2"
              onClick={() => setEnd(end + count)}
            >
              Load More
            </button>
          </div>
        ) : null} */}

      </div>
    </div>
  )
}

const Card=({nft})=>{
  return(
    <div className='w-64  bg-gray-800 shadow-xl shadow-black rounded-lg overflow-hidden m-3 p-3'>
      <img
      src={''}
      alt={''} 
      className='h-60 w-full object-cover  shadow-lg shadow-black rounded-md mb-3'
      />

      <h4 className='text-white font-semibold'>title</h4>
      <p  className="text-gray-400 text-xs my-1 limit">description</p>

      <div className='flex justify-between items-center mt-3 text-white'>
        <div className='flex flex-col'>
        <small>Current Price</small>
        <p  className="text-sm font-semibold">3 ETH</p>
        </div>

        <button
        className='text-[#82fffe] hover:text-white text-sm cursor-pointer'
        onClick={()=>setGlobalState('nftModal','scale-100')}>
          View Details</button>
      </div>
    </div>
  )
}

export default Artworks