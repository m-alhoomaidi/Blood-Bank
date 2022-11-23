import * as React from 'react';
import { styled } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import EditAccount from './EditAccount';
import Box from '@mui/material/Box';
import imgss from '../Images/abdullah.jpg';
import Grid from '@mui/material/Grid';
import Avatar from '@mui/material/Avatar';
import TextField from '@mui/material/TextField';

import IconButton from '@mui/material/IconButton';
import Container from '@mui/material/Container';
import Fab from '@mui/material/Fab';
import { red } from '@mui/material/colors';
import AddAPhotoIcon from '@mui/icons-material/AddAPhoto';
import MoreVertIcon from '@mui/icons-material/MoreVert';
import EditSetting from './EditSetting';
import EditHelping from './EditHelping';
import {
  Menu,MenuItem
} from "@material-ui/core";
import Paper from '@mui/material/Paper';
import LanguageIcon from '@mui/icons-material/Language';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import MailIcon from '@mui/icons-material/Mail';
import { CardContent, CardMedia } from '@mui/material';
import Typography from '@mui/material/Typography';
import { width } from '@mui/system';
const ExpandMore = styled((props) => {
  const { expand, ...other } = props;
  return <IconButton {...other} />;
})(({ theme, expand }) => ({
  transform: !expand ? 'rotate(0deg)' : 'rotate(180deg)',
  marginLeft: 'auto',
  transition: theme.transitions.create('transform', {
    duration: theme.transitions.duration.shortest,
  }),
}));
const Item = styled(Paper)(({ theme }) => ({
  backgroundColor: theme.palette.mode === 'dark' ? '#1A2027' : '#fff',
  ...theme.typography.body2,
  padding: theme.spacing(1),
  textAlign: 'center',
  display : 'flex',
  justifyContent: 'center',
  color: theme.palette.text.secondary,
}));

export default function RecipeReviewCard() {
  const [expanded, setExpanded] = React.useState(false);
  const [anchorEl, setAnchorEl] = React.useState(null);
  
  const MyOptions = [
    "تعديل الإسم",
    "إضافة صورة",
    "تسجيل الخروج"
  ];
  const handleClick = (event) => {
    setAnchorEl(event.currentTarget);
  };
  
  const open = Boolean(anchorEl);
  
  const handleClose = () => {
    setAnchorEl(null);
  };
  const handleExpandClick = () => {
    setExpanded(!expanded);
  };

  return (
    <Container>
    <Box sx={{display:"flex",justifyContent:"center"}}>
    <Grid container spacing={3}   sx={{marginTop:"-170px",justifyContent:"center"}}>
    <Grid minWidth={350}>
          <Item sx={{margin:"20px"}}>
      <Box>
    <CardMedia
        component="img"
        image={imgss}
        alt="Paella dish"
        sx={{
          width:"150px",
          height :"150px",
          borderRadius :"100px",
          marginTop :"10px",
        }}
      />
      <Fab color="primary" aria-label="add" size="small" style={{marginTop :"-60px",marginLeft:"90px",width:"30px"}}>
        <AddAPhotoIcon />
      </Fab>
      <CardHeader title="عبدالله اليفرسي"></CardHeader>
      <CardContent >
        <Typography variant="h5" gutterBottom sx={{
          marginTop :"-25px",
          marginLeft :"20px"
        }}>A+</Typography>
      </CardContent>
      </Box>
      </Item>
    </Grid>
    <Box sx={{width:"600px"}}>
    <Grid >
    <Item sx={{margin:"20px"}}>
    <Grid item xs container direction="column" spacing={2} sx={{
      margin :"10px"
    }}>
      
    <TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        },
        margin:"10px",
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتغيير اسمك الشخصي"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        },
        margin:"10px",
       }}
       
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير رقم الهاتف"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        },
        margin:"10px",
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير فصيلة دمك"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        }
        ,
        margin:"10px",
       }}
       
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتغيير البريد الالكتروني "
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
      </Grid>
     
      </Item>
      </Grid>
        </Box>
   
      <Box>
        <Card>
      <Grid  direction="row"  sx={{
     
    }}>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        },
        margin:"10px",
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير بريدك الالكتروني"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        },
        margin:"10px",
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير بريدك الالكتروني"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"18px",
          color :"black",
        },
        margin:"10px",
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير بريدك الالكتروني"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
</Grid>

</Card>
</Box>

</Grid>
          
    </Box>
    </Container>
  );
}
{/* <TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"15px",
          color :"black",
        }
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير رقم الهاتف"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
<TextField
  variant="standard"
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
          fontSize:"15px",
          color :"black",
        },
        margin :'20px',
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير رقم الهاتف"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
      </Box> */}