  import { makeStyles} from "@material-ui/core/styles";
  import {TextField} from "@material-ui/core";
  import {ThemeProvider,createTheme} from "@material-ui/core/styles";
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
  const classes = useStyles();
    return (
      <>
      <ThemeProvider theme={rtlTheme}>
       <TextField
         name="typeBlood"
         id="ckeckboxes-tags-demo"
         margin="normal"
         required
         fullWidth 
         options={top100Films}
         disableCloseOnSelect  
         disableClearable
         label="فصيلة دمك ؟"
         variant="outlined"
       />          
       <TextField
         name="city"
         id="ckeckboxes-tags-demo"
         margin="normal"
         required
         fullWidth 
         options={top100Films1}
         disableCloseOnSelect       
         disableClearable
         label="المحافظة"
         variant="outlined"
       />
       <TextField
         name="directorate"
         id="ckeckboxes-tags-demo"
         margin="normal"
         required
         fullWidth 
         options={top100Films1}
         disableCloseOnSelect       
         disableClearable
         label="المديـريـة"
         variant="outlined"
       />
       <TextField
         name="TheNeighborhood"
         id="first-name"
         margin="normal"
         required
         fullWidth 
         variant="outlined"
         label="أدخل إسم المنطقة"
       />  
  </ThemeProvider>
       </>
    );
  };
  export default Step2;
  