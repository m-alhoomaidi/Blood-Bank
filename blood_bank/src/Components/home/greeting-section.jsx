import { Box } from "@mui/material";
import { GREETING_VID } from "../../constant/media";

export const GreetingSection = (props) => {
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
    </Box>
  );
};
