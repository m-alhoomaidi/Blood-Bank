import { ThemeProvider } from '@mui/material/styles';
import { theme } from './theme'
import { HomePage, SignIn } from "./pages";
import Search from "./pages/search";
import ProfileUser from "./pages/profile";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import NavBar from './Components/navbar'
const App = () => {
  return(
    <ThemeProvider theme={theme}>
      <BrowserRouter>
        <NavBar />
        <Routes>
          <Route path='/' element={<HomePage />} />
          <Route path='/login' element={<SignIn />} />
          <Route path='/search' element={<Search />} />
          <Route path='/profile' element={<ProfileUser />} />
        </Routes>
      </BrowserRouter>
    </ThemeProvider>
  );
}
export default App;