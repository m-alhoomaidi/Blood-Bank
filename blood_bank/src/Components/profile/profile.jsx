import * as React from 'react';
import Card from '@mui/material/Card';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Divider from '@mui/material/Divider';
import CardMedia from '@mui/material/CardMedia';
import Images from '../../Images/abdullah.jpg'
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';

const TypeBlood = [
    { label: 'A+'},
    { label: 'B+' },
    { label: 'AB+' },
    { label: 'O+' },
    { label: 'A-'},
    { label: 'B-' },
    { label: 'AB-'},
    { label: 'O-'},
  ];
const Profile =()=>{
    return(
        <Box container sx={{margin:"100px",display:"flex",justifyContent:"center"}} >
          <Grid container spacing={5} >
            <Grid item xs={12} md={4} >
              <Card sx={{paddingLeft:"0px"}}>
              <Grid container spacing={3} flexDirection="column">
                <Grid item><Box sx={{display:'flex',justifyContent:"center"}}><CardMedia component="img" image={Images} height={100} sx={{width:"100px",margin:"10px 10px 10px 10px",borderRadius:"50%",display:'flex',justifyContent:"center"}}/></Box></Grid>
                <Grid item><Typography sx={{display:'flex',justifyContent:"center"}}>عبدالله اليفرسي</Typography></Grid>
            <Grid item><Divider/></Grid>
            <Grid item><Box sx={{display:'flex',justifyContent:"center",margin:"-10px 0px 10px 0px"}}> <Button>فتح الاستديو</Button></Box></Grid>
            </Grid>
          </Card>
          </Grid>
          <Grid item>
            <Box sx={{'& .css-8wqzlf-MuiGrid-root':{width: 'calc(100% + 32px)',marginLeft:'0px',marginTop:"0px"}}}>
          <Card >
            <Grid container spacing={3} justifyContent="center" >
          <Grid item>
          <TextField
              margin="normal"
              id="name"
              label="اسمك الرباعي"
              name="name"
              autoFocus
              dir="ltr"
              align="right"
            />
          </Grid>
          <Grid item>
          <Autocomplete
                        disablePortal
                        margin="normal"
                        id="combo-box-demo"
                        options={TypeBlood}
                        sx={{width:220,marginTop:"15px"}}
                         renderInput={(params) => <TextField {...params} label="فصيلة الدم" variant="outlined"/>}
                       />
                      </Grid>
                      <Grid item>
          <TextField
              margin="normal"
              id="email"
              label="عنوان البريد الإلكتروني"
              name="email"
              autoComplete="email"
              dir="ltr"
              align="right"
             
            />
          </Grid>
          </Grid>  
          <Grid container spacing={3} justifyContent="center">
            <Grid item>
            <TextField
              margin="normal"
              label="المحافظة"
              name="city"
              dir="ltr"
              align="right"
              
            />

            </Grid>
            <Grid item>
            <TextField
              margin="normal"
              label="المديرية"
              name="email"
              dir="ltr"
              align="right"
             
            />

            </Grid>
            <Grid item>
            <TextField
              margin="normal"
              id="email"
              label="المنطقة"
              dir="ltr"
              align="right"
              
            />

            </Grid>
            </Grid> 
            <Grid container spacing={3} justifyContent="center">
            <Grid item>
          <TextField
              margin="normal"
              id="phone"
              label="رقم تلفونك"
              name="phone"
              dir="ltr"
              align="right"
            />
          </Grid>
            </Grid>
         </Card>
         </Box>
         <Box sx={{display:"flex",justifyContent:"end"}}>
                <Button variant="contained" sx={{width:"150px",marginTop:"20px"}}>تـعــديـل</Button>
          </Box>
         </Grid>
          </Grid>
        </Box>


    );

};
export default Profile;