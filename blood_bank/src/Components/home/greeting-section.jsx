import { Box, TextField, Typography } from "@mui/material";
import { GREETING_VID } from "../../constant/media";
import { FlexVertical } from "../common/flex-vertical";

export const GreetingSection = (props) => {
  return (
    <Box>
      <Box
        sx={{
          position: "relative",
        }}
      >
        <Box>
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
          <Box
            sx={{
              position: "absolute",
              top: 0,
              width: "100%",
              height: "99%",
              backgroundColor: "gray",
              opacity: 0.3,
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
            }}
          ></Box>
          <Box
            sx={{
              position: "absolute",
              top: 0,
              width: "100%",
              height: "99%",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
            }}
          >
            <FlexVertical>
              <Box>
                <Typography variant="h1" sx={{ color: "white" }}>
                  قربة دم تنقذ حياة
                </Typography>
              </Box>
            </FlexVertical>
          </Box>
        </Box>
      </Box>
    </Box>
  );
};
