import * as React from 'react';
import Divider from '@mui/material/Divider';
import Typography from '@mui/material/Typography';
import List from '@mui/material/List';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import MessageIcon from '@mui/icons-material/Message';
import VerifiedUserOutlinedIcon from '@mui/icons-material/VerifiedUserOutlined';
const EditHelping =()=>{
return (
    <div style={{marginTop:"30px",marginRight:"20px"}}>
    <Divider />
    <Typography variant="h5" gutterBottom >
      مساعدة
    </Typography>
    <List direction="ltr"
      sx={{
        '& .css-tlelie-MuiListItemText-root':{
          marginLeft :"70px",
          marginRight :"18px",
          textAlign: 'right',
          width :"200px",
          fontSize :"30px",
        },
        '& .css-cveggr-MuiListItemIcon-root' :{
          width : "20px",
          minWidth :"26px",

        },
        '& .css-83ijpv-MuiTypography-root' :{
          fontSize : "20px",
          color :"black",

        },
      }}
      >
    <ListItemButton>
    <ListItemIcon alignItems='right' >
    <MessageIcon />

              </ListItemIcon>
              <ListItemText secondary="إسال سؤالا" />
   </ListItemButton>
   
   <Divider/>
   <ListItemButton>
    <ListItemIcon alignItems='right' >

              <VerifiedUserOutlinedIcon/>
              </ListItemIcon>
              <ListItemText secondary="سياسة الخصوصية" />
   </ListItemButton>
   
   <Divider/>
   </List>
    </div>

);
};
export default EditHelping;