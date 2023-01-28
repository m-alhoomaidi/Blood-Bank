import { AboutUsSection } from "../Components/home/about-sections";
import { GreetingSection } from "../Components/home/greeting-section";
import { MedialInstructionsSection } from "../Components/home/medical-instructions";
import TrysignupCenter from "./signupcenter";
import BloodForm from "../Components/centerProfile/bloodForm";
const HomePage = (props) => {
  return (
    <>
      <GreetingSection /> 
      <MedialInstructionsSection />
       <AboutUsSection />
       {/* <TrysignupCenter/> */}
       {/* <BloodForm/> */}
    </>
  );
};

export default HomePage;
