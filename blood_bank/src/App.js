import { ThemeProvider } from '@mui/material/styles';
import { theme } from './theme'
import HomePage from "./pages/home";
const App = () => {
  return (
    <ThemeProvider theme={theme}>
      <HomePage />
    </ThemeProvider>
  );
}
export default App;