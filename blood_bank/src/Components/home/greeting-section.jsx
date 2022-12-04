import { Box, Button, TextField, Typography } from "@mui/material";
import PersonSearchIcon from "@mui/icons-material/PersonSearch";
import backgroundHomeImage from "../../Images/blood-donor.jpg";
import Paper from "@mui/material/Paper";
import InputBase from "@mui/material/InputBase";
import Divider from "@mui/material/Divider";
import IconButton from "@mui/material/IconButton";
import MenuIcon from "@mui/icons-material/Menu";
import SearchIcon from "@mui/icons-material/Search";
import DirectionsIcon from "@mui/icons-material/Directions";
import { GREETING_IMG, GREETING_VID } from "../../constant/media";

export const GreetingSection = (props) => {
  const { children } = props;
  return (
    <Box
      sx={{
        position: "relative",
      }}
    >
      <Box
        sx={{
          width: "100%",
          position: "absolute",
          top: 0,
          left: 0,
        }}
      >
        <video
          autoPlay
          muted
          loop
          style={{
            width: "100%",
          }}
        >
          <source src={GREETING_VID} type="video/mp4" />
        </video>
      </Box>
      <Box
        sx={{
          width: "100%",
          height: "800px",
          position: "absolute",
          top: 0,
          left: 0,
          backgroundColor: "black",
          opacity: 0.5,
        }}
      ></Box>
    </Box>
  );
};

{
  /* <Box
sx={{
  mt: { xs: "120px", md: "130px" },
  mr: { xs: "10px", md: "120px" },
}}
>
<Box>
  <Typography
    sx={{
      fontSize: "4vw",
      color: "black",
    }}
  >
    قربة دم قد تنقذ حياة
  </Typography>
</Box>
<Box>
  <Typography sx={{ color: "black", mr: "10px" }}>
    كن باب النجاة للمحتاجين، والأمل الوحيد، والبطل المنقذ
  </Typography>
</Box> */
}
{
  /* <Box
// sx={{
//   display: "flex",
//   justifyContent: "center",
//   alignItems: "center",
// }}
>
  <Paper
    component="form"
    sx={{
      p: "2px 4px",
      marginTop: "3px",
      display: "flex",
      alignItems: "center",
      width: 400,
    }}
  >
    <IconButton
      type="button"
      sx={{ p: "10px", color: "#c1262e" }}
      aria-label="search"
    >
      <SearchIcon />
    </IconButton>
    <Divider sx={{ height: 28, m: 0.5 }} orientation="vertical" />

    <InputBase
      sx={{ ml: 1, flex: 1 }}
      placeholder="البحث عن متبرع"
      inputProps={{ "aria-label": "search google maps" }}
    />
  </Paper>
</Box> */
}
{
  /* </Box> */
}
