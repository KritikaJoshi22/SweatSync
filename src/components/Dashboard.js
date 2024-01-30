import React from 'react'
import Mynfts from './Mynfts'
import Mycourses from './Mycourses'
import ShowCourse from './ShowCourse'
import Statbox from './Statbox'

function Dashboard() {
  return (
    <div className='flex flex-col'>
       <Statbox/>
        <Mynfts/>
        <Mycourses/>
        <ShowCourse/>
    </div>
  )
}

export default Dashboard