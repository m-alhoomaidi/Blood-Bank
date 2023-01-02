import React from "react";
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import ArrowForwardIcon from '@mui/icons-material/ArrowForward';
import { create } from "jss";
import rtl from "jss-rtl";
import Grid from "@mui/material/Grid";
import {
  StylesProvider,
  jssPreset,
  ThemeProvider,
  createTheme
} from "@material-ui/core/styles";
import {
  Typography,
  Button,
  Stepper,
  Step,
  StepLabel,
  Box,
} from "@material-ui/core";
import {
  useForm,
  FormProvider,
} from "react-hook-form";
import StepsCss from '../Components/stepper/StepsCss';
import Steps1 from "../Components/stepper/Step1Center";
import Step2 from "../Components/stepper/Step2Center";
import LottieApp from "../Components/lottie";
import { HEALTH_LOTTIE} from "../constant/media";
const steps = ['حسابك', 'بياناتك', 'تأكيد'];
const maincolor="#e22c34";
function getStepContent(step) {
  switch (step) {
    case 0:
      return <Steps1 />;
    case 1:
      return <Step2 />;
    default:
      return  ;
  }
}
const SignUpCenter = () => {
  const classes = StepsCss();
  const methods = useForm({
    defaultValues: {
      firstName: "",
      phoneNumber: "",
      TheNeighborhood: "",
    },
  });

  const [activeStep, setActiveStep] = React.useState(0);
  const [skipped, setSkipped] = React.useState(new Set());


  const isStepSkipped = (step) => {
    return skipped.has(step);
  };

  const handleNext = () => {
    let newSkipped = skipped;
    if (isStepSkipped(activeStep)) {
      newSkipped = new Set(newSkipped.values());
      newSkipped.delete(activeStep);
    }

    setActiveStep((prevActiveStep) => prevActiveStep + 1);
    setSkipped(newSkipped);
  };

  const handleBack = () => {
    setActiveStep((prevActiveStep) => prevActiveStep - 1);
  };
  const jss = create({ plugins: [...jssPreset().plugins, rtl()] });
  const rtlTheme = createTheme({ direction: "rtl" });
  return (
    <Grid container component="main" sx={{ height: "100vh", dir: "ltr" }}>
      <Grid item xs={12} md={6}> 
      <Box
          sx={{
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            height: "100%",
          }}
        >
          <LottieApp animationpath={HEALTH_LOTTIE} />
        </Box>
        </Grid>
        <Grid item xs={12} md={6}>
        <Box
          sx={{
            display: "flex",
            width: "100%",
            height: "92%",
            justifyContent: "center",
            alignItems: "center",
            pb: 8,
          }}
        >
          <Box
            sx={{
              display: "flex",
              justifyContent: "center",
              justifyItems: "center",
              flexDirection: "column",
              width: { xs: "90%", md: "70%" },
            }}
          >
      <StylesProvider jss={jss}>
      <Stepper activeStep={activeStep} className={classes.IconSvging} sx={{marginTop:"45px"}}>
        {steps.map((label, index) => {
          const stepProps = {};
          const labelProps = {};
          if (isStepSkipped(index)) {
            stepProps.completed = false;
          }
          return (
            <Step key={label} {...stepProps}>
              <StepLabel {...labelProps} className={classes.IconSvging}>{label}</StepLabel>
            </Step>
          );
        })}
      </Stepper>
      {activeStep === steps.length ? (
        <Typography variant="h1" align="center">
       Thank You
        </Typography>
      ) : (
      <Box>
      <FormProvider {...methods} >
        <form  >
          
      {getStepContent(activeStep)}
        <React.Fragment>
        
          <Box sx={{ display: 'flex', flexDirection: 'row', pt: 0 }}>
            <Button
              color="inherit"
              disabled={activeStep === 0}
              onClick={handleBack}
              sx={{ mr: 1}}
              style={{marginTop:"1px",border :"1px solid #e22c10",color :'white',borderRadius: '10px',backgroundColor:"#e22c34"}}
            >
            <ArrowForwardIcon/>  السابق
            </Button>
            <Box sx={{ flex: '1 1 auto' }} />
            <Button onClick={handleNext} style={{marginTop:"1px",border :"1px solid #e22c10",color :'white',borderRadius: '10px',backgroundColor:"#e22c34"}}>
              {activeStep === steps.length -1 ? ( " التأكيد") :(<>التالي<ArrowBackIcon/></>)}
            </Button>
          </Box>
        </React.Fragment>    
        </form>
       </FormProvider>
      </Box>
      )}
      </StylesProvider>
           </Box>
          </Box>
        </Grid>
    </Grid> 
  );
};

export default SignUpCenter;
