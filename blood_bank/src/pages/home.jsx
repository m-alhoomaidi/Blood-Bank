import NavBar from "../Components/navbar";
import { GreetingSection } from "../Components/home/greeting-section";
import SignInSide from "../Components/home/signin";
const HomePage = (props) => {
  return (
    <>
      <NavBar />
      <GreetingSection/>
       <SignInSide></SignInSide>
    </>
  );
};

export default HomePage;
