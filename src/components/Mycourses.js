import React from 'react'
import { setGlobalState, useGlobalState } from '../store'

function Mycourses() {
  const [courseModal] = useGlobalState('courseModal');
  const [connectedAccount] = useGlobalState('connectedAccount');


  return (
    <div className='mt-7 mb-4'>
      <div className='py-8 w-4/5 mx-auto bg-opacity-50 bg-shadow-xl bg-gray-800 rounded-lg'>
        <h4 className='text-3xl font-bold uppercase interest ml-4 mx-auto'>My Courses</h4>

        <div className='flex flex-wrap justify-center items-center mt-4'>
          {Array(3).fill().map((i) => (
            <Card key={i} />
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

const Card = ({ nft }) => {
  return (
    <div className='w-64 h-80 bg-gray-800 shadow-xl shadow-black rounded-lg overflow-hidden m-3 p-3'>
      <div className='shadow-lg shadow-black rounded-lg mb-3'>
        <img
          src={'https://i.seadn.io/s/raw/files/5c69e6c837fb8f5dfce8cec02a629331.png?auto=format&dpr=1&w=1000'}
          alt={''}
          className='object-cover rounded-md mb-3'
        />
      </div>

      <div className='flex justify-between items-center'>
        <div className='flex flex-col justify-center item-center'>
          <h4 className='text-white font-semibold'>title</h4>
          <p className="text-gray-400 text-xs my-1 limit">description</p>
        </div>

        <div className='flex justify-center items-center my-auto pb-10'>
        <button
          className='text-[#82fffe] hover:text-white text-sm cursor-pointer'
          onClick={() => setGlobalState('courseModal', 'scale-100')}>
          View
        </button>
        </div>

      </div>
    </div>
  )
}

export default Mycourses