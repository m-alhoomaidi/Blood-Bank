import React, { useState } from 'react';
import { Avatar, Box, Card,Grid, Typography} from '@mui/material';
import LocalPhoneIcon from '@mui/icons-material/LocalPhone';
import Button from '@mui/material/Button';
import ClockIcon from '@mui/icons-material/AccessTime';
import MessageIcon from '@mui/icons-material/Message';
const CardSearch = (props) => {    
    return (
    <Box container>
       <Card sx={{ height: '100%' }}>
          <Grid container spacing={3}>
            <Grid item>
                <Avatar
                   sx={{backgroundColor: 'error.main',marginRight:"20px"}}>
                     A+
                </Avatar>
             </Grid>
            <Grid item>
                <Typography sx={{marginTop:"8px"}}>عبدالله احمد</Typography>
            </Grid>
            <Grid item xs={4}></Grid>
            </Grid>
          <Grid container spacing={2} justifyContent="center" flexDirection="column">
          <Grid item >
            <Box container sx={{marginTop:"-20px"}}>
            <ClockIcon sx={{color:"dimgrey", margin :"-5px 80px 15px 0px", fontSize :"15px"}}/>
              <Typography sx={{margin:"-40px 100px 0px 0px",color:"dimgrey"}}>10/12/2022 </Typography>
            </Box>
            </Grid>
           <Grid item >
              <Typography sx={{marginRight:"80px"}}>المنطقة - السبل</Typography>
            </Grid>
            <Grid item xs={2}></Grid>
          </Grid>
          <Box container sx={{margin:"20px 20px"}}>
            <Grid container spacing={6} >
            <Grid item >
               <Button variant="contained" sx={{background:"green", "&:hover": {
                  backgroundColor: "#69af69",
                  textDecoration: "none",
                },}} ><LocalPhoneIcon /></Button>
            </Grid>
            <Grid item >
                <Button variant="contained" sx={{background:"yellow", "&:hover": {
                  backgroundColor: "#afa314",
                  textDecoration: "none",
                },}}><MessageIcon /></Button>
             </Grid>
            </Grid>
          </Box>
       </Card>
    </Box>
  );
};
export default CardSearch;