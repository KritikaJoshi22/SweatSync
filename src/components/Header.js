import React from 'react'
import fire from '../assets/fire.png'
 
function Header() {
  return (
    <div className='top-0 bg-slate-800 bg-opacity-30 w-full h-20 md:felx-0.5 flex justify-between items-center py-4 mx-auto  shadow-xl'>
        <div className='ml-4 flex justify-center items-center'>
            <h1 className='font-medium text-white md:text-3xl text-2xl w-32 cursor-pointer'>SweatSync</h1>
        </div>
{/* jb selected honge to text color dusra kr denge  */}
        <ul className=' navbar-menu_container flex flex-row justify-center items-center text-white font-medium'>
            <li className='mx-4 cursor-pointer'>NFT Marketplace</li>
            <li className='mx-4 cursor-pointer'>Courses</li>
            <li className='mx-4 cursor-pointer'>Dashboard</li>
            <li className='mx-4 cursor-pointer'>Community</li>
        </ul>

        <div className='flex justify-center items-center p-2'>
          <img src={fire} className='w-8 m-2 rounded-full'/>
          <p className='text-gray-300 font-semibold'>6</p>
        </div>

        <button 
          className='shadow-xl shadow-black text-gray-800 font-medium p-1 md:p-2
          interest-button rounded-full cursor-pointer'
          > Connect Wallet</button>
       
    </div>
  )
}

export default Header