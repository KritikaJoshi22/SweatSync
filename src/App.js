import Header from "./components/Header";
import './App.css';
import Artworks from "./components/Artworks";
import ShowNFT from "./components/ShowNFT";
import Courses from "./components/Courses";
import ShowCourse from "./components/ShowCourse";
import Dashboard from "./components/Dashboard";

function App() {

  return (
    <div className="">
      <div className="w-full h-full -z-10 header-background fixed top-0 left-0 right-0 bottom-0 bg-[#010922]">
      <div className="absolute top-[100px] right-[100px] bg-[#4c39c4] w-5/12 h-[200px] rounded"></div>
      <div className="absolute bottom-[100px] left-[50px] bg-blue-600 w-[200px] h-[200px] rounded "></div>
      <div className="absolute bottom-[100px] right-[50px] bg-[#915DFF] w-[200px] h-[200px] rounded "></div>
    </div>

    <div className="min-h-screen">
      <Header/>

      <Dashboard/>

      {/* <Artworks/>
      <ShowNFT/> */}

      {/* <Courses/>
      <ShowCourse/> */}
    </div>
    </div>
  );
}

export default App;
