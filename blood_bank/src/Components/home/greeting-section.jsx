import { Box, Button, Typography } from "@mui/material";
import PersonSearchIcon from "@mui/icons-material/PersonSearch";
import backgroundHomeImage from "../../Images/blood-donor.jpg";
import Paper from '@mui/material/Paper';
import InputBase from '@mui/material/InputBase';
import Divider from '@mui/material/Divider';
import IconButton from '@mui/material/IconButton';
import MenuIcon from '@mui/icons-material/Menu';
import SearchIcon from '@mui/icons-material/Search';
import DirectionsIcon from '@mui/icons-material/Directions';

export const GreetingSection = (props) => {
  const { children } = props;
  return (
    <Box
      sx={{
        width: "100%",
        height: "600px",
        backgroundImage: `url(${backgroundHomeImage})`,
        backgroundSize: "cover",
        backgroundRepeat: "no-repeat",
        display: "flex",
        justifyContent: "center",
        alignItems: "center",
      }}
    >
      <Box
        sx={{ dispaly: "flex", justifyContent: "center", alignItems: "center" }}
      >
        <Typography variant="h3">قربة دم قد تنقذ حياة</Typography>
        <Box
          sx={{
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
          }}
        >
            
    <Paper
      component="form"
      sx={{ p: '2px 4px',marginTop:"3px", display: 'flex', alignItems: 'center', width: 400 }}
    >
    <IconButton type="button" sx={{ p: '10px', color: "#c1262e" }} aria-label="search">
        <SearchIcon />
    </IconButton>
      <Divider sx={{ height: 28, m: 0.5 }} orientation="vertical" />
    
      <InputBase
        sx={{ ml: 1, flex: 1 }}
        placeholder="البحث عن متبرع"
        inputProps={{ 'aria-label': 'search google maps' }}
      />
    </Paper>
          {/* <Button
            variant="contained"
            sx={{ backgroundColor: "#c1262e" }}
            startIcon={<PersonSearchIcon sx={{ marginLeft: "8px" }} />}
          >
            {" "}
            البحث عن متبرع{" "}
          </Button> */}
        </Box>
      </Box>
    </Box>
  );
};



