import {Controller,useFormContext } from "react-hook-form";
  import { makeStyles} from "@material-ui/core/styles";
  import {TextField,Box} from "@material-ui/core";
  import BloodtypeIcon from '@mui/icons-material/Bloodtype';
  import Autocomplete from '@mui/material/Autocomplete';
  import {  InputAdornment, Typography } from '@mui/material';
  import {ThemeProvider,createTheme} from "@material-ui/core/styles";
  import CssBaseline from "@material-ui/core/CssBaseline";
  import LocationCityIcon from '@mui/icons-material/LocationCity';
  import LocationOnIcon from '@mui/icons-material/LocationOn';
  import MyLocationIcon from '@mui/icons-material/MyLocation';
  import { FormGroup } from '@mui/material';
  import {
    Button,
    Checkbox,
    Grid,
    Link,
    FormControlLabel
  } from "@material-ui/core";
const rtlTheme = createTheme({ direction: "rtl" });
const useStyles = makeStyles((theme) => ({
    button: {
      marginRight: theme.spacing(5),
    },
    textField: {
     [ `& fieldset`] : {
        borderRadius: '7px',
        color :'black', 
      },
      marginBottom :theme.spacing(1),
      borderRadius: '7px',
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
  const top100Films1 = [
    {label: 'Ibb'},
    { label: 'Taiz' },
    { label: 'Aden' },
    { label: 'Sana`a' },
    { label: 'Theamar'},
    { label: 'Marib' },
    { label: 'Hudidah'},
    { label: 'Al-Mokala'},
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
          name="city"
          render={({ field }) => (
            <Autocomplete
            id="ckeckboxes-tags-demo"
            options={top100Films1}
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
                      < LocationCityIcon/>
                    </InputAdornment>
                  ),
                }; 
                return(
                  <TextField
                  required
                  className={classes.textField}
                  placeholder="المحافظة"
                  variant="outlined"
                  {...params}
                  InputProps={InputProps}
                  />
                );  
              }
            }
   />   
      )}/>
        <Controller
          control={control}
          name="directorate"
          render={({ field }) => (
            <Autocomplete
            id="ckeckboxes-tags-demo"
            options={top100Films1}
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
              marginTop :"20px",
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
                      < LocationOnIcon/>
                    </InputAdornment>
                  ),
                }; 
                return(
                  <TextField
                  required
                  className={classes.textField}
                  placeholder="المديـريـة"
                  variant="outlined"
                  {...params}
                  InputProps={InputProps}
                  />
                );  
              }
            }
   />
   
      )}
        />
        <Controller
          control={control}
          name="TheNeighborhood"
          render={({ field }) => (
            <TextField
            required
            id="first-name"
              className={classes.textField}
              inputProps={{className : classes.labels}}
             InputProps={{
            startAdornment: (
              <InputAdornment position="start" style={{marginLeft:"-10px"}}
              >
                < MyLocationIcon style={{marginRight: '15px',}}
                />
              </InputAdornment>
            ),
          }}
              variant="outlined"
              placeholder="أدخل إسم المنطقة"
              fullWidth
             margin="normal"
              {...field}
            />  
          )}
        />
               <Controller
          control={control}
          name="firstName"
          render={({ field }) => (
            <div>
               <Grid container justifyContent="center">
              <Typography style={{fontSize:"1.0em",fontWeight:"bold",marginTop:"5px" }}>حرصا على سلامة البيانات يرجى إرفاق وثيقة تثبتهوية المركز  </Typography>
          <Button
          id="Phone-Number"
            variant="outlined"
            required="phone"
            style={{marginTop :"5px"}}
            value ="صورة إثبات هوية المركز"
            fullWidth
          >صورة إثبات هوية المركز</Button>
          <FormGroup sx={{marginTop :"5px"}}>
            <FormControlLabel control={<Checkbox
         color="primary" required
          />} label={
            <Box component="div" fontSize="1.2em">أوافق على <Link style={{color :"dodgerblue",fontWeight:'bold',}}>سياسية الخصوصية</Link></Box>
          }
           />
            </FormGroup>
            </Grid>
             </div>
            
          )}
        />           
         </Box>
  </ThemeProvider>
       </>
    );
  };
  export default Step2;
  