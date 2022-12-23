import {
  Box,
  Card,
  CardContent,
  CardMedia,
  Grid,
  Typography,
} from "@mui/material";
import { AboutUsData } from "../../profile";
import { FlexCenter } from "../common/flex-center";
import { FlexVertical } from "../common/flex-vertical";
import { GridContainer } from "../common/grid-container";
import { SectionTitle } from "../common/section-title";

export const AboutUsSection = () => {
  return (
    <>
      <FlexCenter mt={2} mb={2}>
        <SectionTitle title="من نحن" />
      </FlexCenter>
      <GridContainer mb={2}>
        <Grid item xs={12} md={6}>
          <CardMedia
            component="img"
            image="/greeting_img.jpg"
            height="300px"
            sx={{
              objectFit: "cover",
            }}
          />
        </Grid>
        <Grid item xs={12} md={6}>
          <Box>
            <FlexVertical p={4}>
              <Typography sx={{ textAlign: "justify" }}>
                {AboutUsData.body}
              </Typography>
            </FlexVertical>
          </Box>
        </Grid>
      </GridContainer>
    </>
  );
};
