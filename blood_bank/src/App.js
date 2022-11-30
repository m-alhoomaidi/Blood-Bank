import CreateAccount from "./Accounts/CreateAccount";
import CreateCenterAccount from "./Accounts/CreateCenterAccount";
import HomePage from "./Home/HomePage";
import EditUser from "./Edits/EditUser";
import MainHome from "./Home/MainHome";
import {  BrowserRouter ,Route ,Routes} from 'react-router-dom' 
import UserLogin from "./Accounts/UserLogin";
import { CssBaseline,Container, Paper, Box } from "@material-ui/core";
const App = ()=> {
  return (
    <BrowserRouter> 
    {/* //<Container> */}
      {/* <CssBaseline />
    <Container component={Box} p={3} sx={{
      marginTop :"60px",
    }}>
      <Paper component={Box} p={1} > */}
     
     
         
       <HomePage />
      <Routes>
      <Route  path="/" element={<MainHome></MainHome>} /> 
      <Route  path="/UserLogin" element={<UserLogin></UserLogin>} /> 
      <Route  path="/CreateAccount" element={<CreateAccount></CreateAccount>} /> 
      <Route  path="/CreateCenterAccount" element={<CreateCenterAccount></CreateCenterAccount>} />  
      <Route  path="/EditUser" element={<EditUser></EditUser>} />  
      </Routes>
      
      
      
      
      
      
      
    {/* </Container> */}
    </BrowserRouter>
  );
}
export default App;