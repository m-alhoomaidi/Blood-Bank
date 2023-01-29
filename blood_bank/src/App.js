import { ThemeProvider } from '@mui/material/styles';
import { theme } from './theme'
import { HomePage, SignIn } from "./pages";
import Search from "./pages/search";
import ProfileUser from "./pages/profile";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import NavBar from './Components/navbar'
import SignUp from './pages/signup';
import { Footer } from './Components/footer';
import { AuthConsumer, AuthProvider } from './context/auth-context';
import { AuthGuard } from './context/auth-gaurd';
import MapPage from './pages/map';
import { Box } from '@mui/material';
import Aboutus from './pages/aboutus';
import SignUpCenter from './pages/signupcenter';
import CenterProfiles from './pages/centerprofile';
const App = () => {
  return (
    <ThemeProvider theme={theme}>
      <AuthProvider>
        <BrowserRouter>
          <AuthGuard>
            <Box sx={{backgroundColor:"#fafafa",}} px={{md:5,xs:1}}>
            <NavBar />
            <Routes>
              <Route path='/' element={<HomePage />} />
              <Route path='/login' element={<SignIn />} />
              <Route path='/search' element={<Search />} />
              <Route path='/profile' element={<ProfileUser />} />
              <Route path='/signup' element={<SignUp />} />
              <Route path='/map' element={<MapPage />} />
              <Route path='/aboutus' element={<Aboutus/>}/>
              <Route path='/SignUpCenter'element={<SignUpCenter/>}/>
               <Route path='/centerprofile'element={<CenterProfiles/>}/>
            </Routes>
            </Box>
            {/* <Footer /> */}
          </AuthGuard>
        </BrowserRouter>
      </AuthProvider>
    </ThemeProvider>
  );
}
export default App;