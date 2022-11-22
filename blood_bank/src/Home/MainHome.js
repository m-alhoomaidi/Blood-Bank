import React, { useCallback } from 'react'; 
import { useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import MobileStepper from '@mui/material/MobileStepper';
import Paper from '@mui/material/Paper';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import KeyboardArrowLeft from '@mui/icons-material/KeyboardArrowLeft';
import KeyboardArrowRight from '@mui/icons-material/KeyboardArrowRight';
import SwipeableViews from 'react-swipeable-views';
import { autoPlay } from 'react-swipeable-views-utils';
import  Img from '../Images/BloodBank.jfif';
import Img2 from '../Images/BloodBank2.jfif';
import Img3 from '../Images/BloodBank3.jfif';
import Img4 from '../Images/BloodBank4.jfif';
import Chart from 'react-apexcharts';


const AutoPlaySwipeableViews = autoPlay(SwipeableViews);

const images = [
  {
    label: 'تبرعك يساوي ...حياة',
    imgPath:Img,
  },
  {
    label: 'بنك الدم',
    imgPath:Img2,
  },
  {
    label: 'امنح حياة بدمك',
    imgPath:Img3,
  },
  {
    label: 'قطرة من دمك قد تنقذ حياة',
    imgPath:Img4,
  },
];

function MainHome() {
  const theme = useTheme();
  const [activeStep, setActiveStep] = React.useState(0);
  const maxSteps = images.length;
  const handleNext = () => {
    setActiveStep((prevActiveStep) => prevActiveStep + 1);
  };

  const handleBack = () => {
    setActiveStep((prevActiveStep) => prevActiveStep - 1);
  };

   const handleStepChange = (step) => {
     setActiveStep(step);
   };

//    const getser=React.useCallback((series) => {
    
//     const col={
//       series1: "red",
//       series2: "red",
//       series3: "red",
//       series4: "red",
//       series5: "red",
//     };
//     return {
// fill :col[series.label],

//     };
     
//    },[]);

  return (
    <div>
    <Box sx={{ maxWidth: 2000, flexGrow: 1 }}>
      <Paper
        square
        elevation={0}
        sx={{
          display: 'flex',
          alignItems: 'center',
          height: 50,
          pl: 2,
          bgcolor: 'background.default',
          justifyContent: 'center',
    
        }}
      >
        <Typography style={{fontSize :"25px",fontWeight :'blod',}}>{images[activeStep].label}</Typography>
      </Paper>
      <AutoPlaySwipeableViews
        axis={theme.direction === 'rtl' ? 'x-reverse' : 'x'}
        index={activeStep}
        onChangeIndex={handleStepChange}
        enableMouseEvents
      >
        {images.map((step, index) => (
          <div key={step.label}>
            {Math.abs(activeStep - index) <= 2 ? (
              <Box
                component="img"
                sx={{
                  height: 400,
                  display: 'block',
                  overflow: 'hidden',
                  width: '100%',
                  
                 
                }}
                src={step.imgPath}
                alt={step.label}
              />
            ) : null}
          </div>
        ))}
      </AutoPlaySwipeableViews>
      <MobileStepper
        steps={maxSteps}
        position="static"
        activeStep={activeStep}
        nextButton={
          <Button
            size="small"
            onClick={handleNext}
            disabled={activeStep === maxSteps - 1}
          >
            التالي
            {theme.direction === 'rtl' ? (
              <KeyboardArrowLeft />
            ) : (
              <KeyboardArrowRight />
            )}
          </Button>
        }
        backButton={
          <Button size="small" onClick={handleBack} disabled={activeStep === 0}>
            {theme.direction === 'rtl' ? (
              <KeyboardArrowRight />
            ) : (
              <KeyboardArrowLeft />
            )}
            االسابق
          </Button>
        }
      />
      <Grid container marginTop="100px"  justifyContent="left" width={800}>      
          <Chart 
          type="donut"
          width={400}
          height={ 550}
          series={[45,67,89,34,43]}
          
          options={{
            chart:{
              type :'donut',

            },
            labels :[
             '','','','',''
            ],
            responsive :[{
              breakpoint :400,
              options:{
                chart:{
                  width:200,

                },
                legend :{
                  position:'bottom'
                }

              }

            }],
              title:{
                text:"إحصائيات",
                align:"center",
                margin : 10,
                style :{
                  color : "red",
                  fontSize : '25px',

                },
              
             },
           dataLabels:{
              enabled:true,
               }
          }}
          />
          </Grid>
    </Box>
  </div>
  );
}

export default MainHome;