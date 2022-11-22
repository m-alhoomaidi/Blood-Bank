import * as React from 'react';
import { makeStyles} from "@material-ui/core/styles";
const StepsCss = makeStyles((theme) => ({
    button: {
      marginRight: theme.spacing(5),
    },
    textField: {
     [ `& fieldset`] : {
        borderRadius: '20px',
        color :'black',
      },
      marginBottom :theme.spacing(1),
      background :'rgb(251, 142, 99,0.6)',
      borderRadius: '20px',
      color :'black',
      fontWeight: 'bold',
      '& .MuiSvgIcon-root' :{
        fill :"black",
          },
  },
  
  IconSvging : {
   '& .MuiStepIcon-active' :
   {
    fill :"red",
   },
   '& .MuiStepIcon-completed' :{
  fill :"green",
   },
  },
  labels :{
    color :'black',
  fontWeight :'bold',
  fontSize :'1.2em',
  marginLeft :'20px',
  
  },
  
  }));
  export default StepsCss;