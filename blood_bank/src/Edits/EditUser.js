import * as React from 'react';
import { styled } from '@mui/material/styles';
import Card from '@mui/material/Card';
import CardHeader from '@mui/material/CardHeader';
import EditAccount from './EditAccount';
import Box from '@mui/material/Box';
import imgss from '../Images/BloodBank2.jfif';
import Grid from '@mui/material/Grid';
import Avatar from '@mui/material/Avatar';
import IconButton from '@mui/material/IconButton';
import Fab from '@mui/material/Fab';
import { red } from '@mui/material/colors';
import AddAPhotoIcon from '@mui/icons-material/AddAPhoto';
import MoreVertIcon from '@mui/icons-material/MoreVert';
import EditSetting from './EditSetting';
import EditHelping from './EditHelping';
import {
  Menu,MenuItem
} from "@material-ui/core";
import LanguageIcon from '@mui/icons-material/Language';
import InboxIcon from '@mui/icons-material/MoveToInbox';
import MailIcon from '@mui/icons-material/Mail';
import { CardMedia } from '@mui/material';
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
    <Grid container spacing={0}  justifyContent="center" sx={{marginTop:"-80px"}}>
      <Box sx={{width:"700px"}}>
    <Card sx={{height:"150px",background:"rgb(235, 63, 63)"}}>
      <CardHeader sx={{
          '& .css-et1ao3-MuiTypography-root':{
            marginRight :"20px",
            fontSize : "20px"
          }
          
          }}
        avatar={
          <Avatar sx={{ bgcolor: red[500]}} aria-label="recipe" src={imgss}>
            1
          </Avatar>
        }
        action={
          <IconButton
        aria-label="more"
        onClick={handleClick}
        aria-haspopup="true"
        aria-controls="long-menu"
      >
        <MoreVertIcon />
      </IconButton>
        }
        title="عبدالله اليفرسي"
      />
       <Menu 
       anchorEl={anchorEl} 
       keepMounted onClose={handleClose} 
       open={open}>
       {MyOptions.map((option) => (
         <MenuItem
           key={option} 
           onClick={handleClose}>
           {option}
         </MenuItem>
       ))}
     </Menu>
    </Card>
    <Fab color="secondary" aria-label="add" style={{marginTop :"-30px",marginRight:"20px"}}>
        <AddAPhotoIcon />
      </Fab>
    <EditAccount/>
    <EditSetting/>
    <EditHelping/>
    </Box>
    </Grid>
  );
}