import { ThemeProvider } from '@mui/material/styles';
import { theme } from './theme'
import { HomePage, SignIn } from "./pages";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import NavBar from './Components/navbar'
const App = () => {
  return (
    <ThemeProvider theme={theme}>
      <BrowserRouter>
        <NavBar />
        <Routes>
          <Route path='/' element={<HomePage />} />
          <Route path='/login' element={<SignIn />} />
        </Routes>
      </BrowserRouter>
    </ThemeProvider>
  );
}
export default App;