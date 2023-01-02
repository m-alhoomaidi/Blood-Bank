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
import Paper from '@mui/material/Paper';

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
        <Box  sx={{marginTop:"100px"}}>
          <Grid container spacing={4} justifyContent="center">
            <Grid item xs={10} md={4}>
              <Card>
                <Box sx={{display:"flex",justifyContent:"center"}}>
              <CardMedia component="img" image={Images} height={100} sx={{width:"100px",margin:"10px 10px 10px 10px",borderRadius:"50%"}}/> </Box>
               <Typography sx={{display:'flex',justifyContent:"center",margin:"5px 0px 10px 0px"}}>عبدالله اليفرسي</Typography>
           <Divider/>
            <Box sx={{display:'flex',justifyContent:"center",margin:"30px 0px 10px 0px"}}> <Button>تغيير الصورة</Button></Box>
           
          </Card>
          </Grid>
          <Grid item xs={12} md={8}>
          <Paper  sx={{
          p: 2,
          margin: "auto",
          flexGrow: 1,
          backgroundColor: (theme) =>
            theme.palette.mode === "dark" ? "#1A2027" : "#fff",
        }}>
          <Grid container spacing={3} flexDirection="row" justifyContent="center">
          
          
          <Grid item xs={10} md={6}>
          <TextField
          fullWidth
              id="name"
              label="اسمك الرباعي"
              name="name"
              autoFocus
              dir="ltr"
             
            />
          </Grid>
          <Grid item xs={10} md={4}>
          <Autocomplete
          fullWidth
                        disablePortal
                       
                        id="combo-box-demo"
                        options={TypeBlood}
                         renderInput={(params) => <TextField {...params} label="فصيلة الدم" variant="outlined"/>}
                       />
                      </Grid>
                      <Grid item xs={10} md={6}>
          <TextField
         
         fullWidth
              id="email"
              label="عنوان البريد الإلكتروني"
              name="email"
              autoComplete="email"
              dir="ltr"
             
             
            />
          </Grid>
            
            <Grid item xs={10} md={4}>
             <TextField
             fullWidth
              id="phone"
              label="رقم تلفونك"
              name="phone"
              dir="ltr"
              align="right"
            />

            </Grid>
            <Grid item xs={10} md={4}>
            <TextField
            fullWidth
              margin="normal"
              label="المحافظة"
              name="city"
              dir="ltr"
              align="right"
              
            />
          </Grid>
          <Grid item xs={10} md={4}>
            <TextField
            fullWidth
              margin="normal"
              label="المديرية"
              name="email"
              dir="ltr"
              align="right"
             
            />

            </Grid>
            <Grid item xs={10} md={4}>
            <TextField
            fullWidth
              margin="normal"
              id="email"
              label="المنطقة"
              dir="ltr"
              align="right"
              
            />

            </Grid> 
         </Grid>
         <Box sx={{display:"flex",justifyContent:"end"}}>
                <Button variant="contained" sx={{width:"150px",marginTop:"20px"}}>حـــفــظ</Button>
          </Box>
         </Paper>
         </Grid>
         </Grid>
        </Box>


    );

};
export default Profile;