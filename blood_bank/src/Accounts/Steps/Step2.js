import {Controller,useFormContext } from "react-hook-form";
  import { makeStyles} from "@material-ui/core/styles";
  import LocalPhoneIcon from '@mui/icons-material/LocalPhone';
  import PermIdentityOutlinedIcon from '@mui/icons-material/PermIdentityOutlined';
  import {TextField,Box} from "@material-ui/core";
  import BloodtypeIcon from '@mui/icons-material/Bloodtype';
  import Autocomplete from '@mui/material/Autocomplete';
  import {  InputAdornment } from '@mui/material';
  import {ThemeProvider,createTheme} from "@material-ui/core/styles";
  import CssBaseline from "@material-ui/core/CssBaseline";
const rtlTheme = createTheme({ direction: "rtl" });
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
const top100Films = [
  { label: 'A+'},
  { label: 'B+' },
  { label: 'AB+' },
  { label: 'O+' },
  { label: 'A-'},
  { label: 'B-' },
  { label: 'AB-'},
  { label: 'O-'},
];
const Step2 = () => {
    const { control } = useFormContext();
    const classes = useStyles();
    return (
      <>
      <ThemeProvider theme={rtlTheme}>
      <CssBaseline />
      <Box m={4} >
        <Controller
          control={control}
          name="firstName"
          render={({ field }) => (
            <TextField
              id="first-name"
              className={classes.textField}
              inputProps={{
                className :classes.labels}}
             InputProps={{
            startAdornment: (
              <InputAdornment position="start" style={{marginLeft:"-10px"}}>
                < PermIdentityOutlinedIcon style={{marginRight: '15px',}}/>
              </InputAdornment>
            ),
          }}
              variant="outlined"
              placeholder="أدخل اسمك الرباعي"
              fullWidth
             margin="normal"
              {...field}
             
            />
          )}
        />
         <Controller
          control={control}
          name="phoneNumber"
          render={({ field }) => (
            <TextField
              id="Phone-Number"
              variant="outlined"
              required="phone"
              style={{marginBottom:"20px",}}
              className={classes.textField}
              placeholder="أدخل رقم تلفونك "
              fullWidth
              inputProps={{
                className :classes.labels}}
              InputProps={{
                startAdornment: (
                  <InputAdornment position="start" style={{marginLeft:"-10px"}}>
                    <  LocalPhoneIcon style={{marginRight: '15px',}}/>
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
          name="typeBlood"
          render={({ field }) => (
           
            <Autocomplete
            id="ckeckboxes-tags-demo"
            options={top100Films}
            disableCloseOnSelect       
            disableClearable
            sx ={{
              '& .css-1q60rmi-MuiAutocomplete-endAdornment' :{
                position: 'relative',
                right :'0px',
                
              },
              '& .MuiSvgIcon-root' : {
                marginLeft : '10px',
              },
            }}
            renderInput={(params) => 
              {
                const InputProps={...params.InputProps,
                  style :{color :"black",
                  fontWeight: 'bold',
                  fontSize :'1.2rem',
                  marginLeft :'50px',
                },
                  startAdornment: (
                    <InputAdornment position="start">
                      < BloodtypeIcon/>
                    </InputAdornment>
                  ),
                }; 
                return(
                  <TextField
                  required
                  className={classes.textField}
                  placeholder="فصيلة دمك ؟"
                  variant="outlined"
                  {...params}
                  InputProps={InputProps}
                  />
                );  
              }
            }
   />)}
      />       
         </Box>
  </ThemeProvider>
       </>
    );
  };
  export default Step2;
  