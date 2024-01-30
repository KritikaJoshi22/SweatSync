import React from 'react'
import Identicon from 'react-hooks-identicons'
import { FaTimes } from 'react-icons/fa'
import { setGlobalState, useGlobalState } from '../store'
// import { buyNFT } from '../blockchain'

function ShowCourse() {
  const [courseModal] = useGlobalState('courseModal');
//   const [connectedAccount] = useGlobalState('connectedAccount');


  return (
    <div className={`fixed top-0 left-0 w-full h-screen flex justify-center 
      items-center bg-black bg-opacity-50 transform
      transition-transform duration-300 ${courseModal}`}>
      <div className='flex flex-col bg-[#151c25] shadow-xl shadow-[#59a6a6] rounded-xl p-6 w-4/5 md:w-3/6'>
        <div className='flex justify-between items-center'>
          <p className='font-semibold text-gray-200'>Buy Course</p>
          <button
            type="button"
            onClick={() => setGlobalState('courseModal', 'scale-0')}>
            <FaTimes className="text-gray-200" />
          </button>
        </div>
 
        <div className='flex justify-center items-center rounded-xl mt-5
               shrink-0 overflow-hidden h-40 w-40"'>
          <img
            src={''}
            alt={''}
            className='h-full w-full object-cover cursor-pointer'
          />

        </div>

        <div className='flex flex-col justify-start mt-5'>
          <h4 className="text-white font-semibold">title</h4>
          <p className="text-gray-400 text-xs my-1">description</p>

          <div className='text-white flex justify-between items-center mt-3'>
            <div className='flex justify-start items-center'>
              <Identicon
                size={50}
                string={''}
                className='h-10 w-10 rounded-full object-contain mr-3'
              />

              <div className='flex flex-col'>
                <small className="text-white font-bold">@owner</small>
                <small className="text-[#82fffe] font-semibold">owner</small>
              </div>
            </div>

            <div className="flex flex-col">
              <small className="text-xs">Price</small>
              <p className="text-sm font-semibold">3 ETH</p>
            </div>
          </div>
        </div>


        {/* {connectedAccount === nft?.owner ? (
          <button
            className="w-full text-white text-md bg-[#af0fff]
                py-2 px-5 rounded-full border border-transparent
               hover:bg-transparent hover:text-[#af0fff]
               hover:border hover:border-[#af0fff] mt-5"
            onClick={onChangePrice}
          >
            Change Price
          </button>
        ) : (
          <button
            className="w-full text-white text-md bg-[#af0fff]
                 py-2 px-5 rounded-full border border-transparent
                hover:bg-transparent hover:text-[#af0fff]
                hover:border hover:border-[#af0fff] mt-5"
            onClick={handleNFTPurchase}
          >
            Purchase Now
          </button>
        )} */}

        <button
            className="w-full text-[#151c25] text-md bg-[#82fffe]
                 py-2 px-5 rounded-full border border-transparent
                hover:bg-transparent hover:text-[#82fffe]
                hover:border hover:border-[#82fffe] mt-5"
          >
            Purchase Now
          </button>
      </div>
    </div>
  )
}

export default ShowCourse