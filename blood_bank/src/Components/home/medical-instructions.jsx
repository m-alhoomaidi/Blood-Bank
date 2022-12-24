import { Grid, Typography } from "@mui/material";
import { Box } from "@mui/system";
import { SECONDARY_COLOR } from "../../constant/color";
import { MedicalInstructions } from "../../profile";
import { FlexCenter } from "../common/flex-center";
import { GridContainer } from "../common/grid-container";
import { SectionTitle } from "../common/section-title";
import { MedicalInstructionsCard } from "./card";

export const MedialInstructionsSection = () => {
  return (
    <>
      <FlexCenter mb={2}>
        <SectionTitle title="إرشادات طبية" />
      </FlexCenter>
      <Box sx={{ backgroundColor: SECONDARY_COLOR }}>
        <GridContainer>
          {MedicalInstructions.map((data, index) => (
            <Grid item xs={12} md={4} key={index}>
              <MedicalInstructionsCard {...data} />
            </Grid>
          ))}
        </GridContainer>
      </Box>
    </>
  );
};
