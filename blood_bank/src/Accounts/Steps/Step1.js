import {Controller,useFormContext,} from "react-hook-form";
  import {TextField} from "@material-ui/core";
  import {  InputAdornment } from '@mui/material';
  import EmailIcon from '@mui/icons-material/Email';
  import PasswordOutlinedIcon from '@mui/icons-material/PasswordOutlined';
  import { makeStyles} from "@material-ui/core/styles";
  const useStyles = makeStyles((theme) => ({
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
  labels :{
    color :'black',
  fontWeight :'bold',
  fontSize :'1.2em',
  marginLeft :'20px',
  
  },
  }));
//import StepsCss from './StepsCss';
const Steps1 = () => {
    const { control } = useFormContext();
    const classes = useStyles()
    return (
      <>
      <Controller
          control={control}
          name="userEmail"
          render={({ field }) => ( 
        <TextField  id="userEmail"  variant="outlined" fullWidth
           type='email'
           required
           className={classes.textField}
           placeholder='أدخل بريدك الالكتروني'
           inputProps={{
        className :classes.labels}}
           InputProps={{
             startAdornment: (
               <InputAdornment position="start">
                 <  EmailIcon/>
               </InputAdornment>
             ),
           }}
           margin="normal"
           {...field}
           />
        )}
        />
        <Controller
          control={control}
          name="password"
          render={({ field }) => (
            <TextField
              id="password"
              required
              className={classes.textField}
              inputProps={{
                className :classes.labels}}
             InputProps={{
            startAdornment: (
              <InputAdornment position="start">
                < PasswordOutlinedIcon/>
              </InputAdornment>
            ),
          }}
          type="password"
          variant="outlined"
          placeholder=' إدخل كلمة السر'
          fullWidth
         margin="normal"
          {...field}
        />
      )}
    />
      </>
    );
  };
  export default Steps1;