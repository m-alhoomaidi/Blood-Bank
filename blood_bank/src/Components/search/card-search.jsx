import React, { useState } from 'react';
import { Avatar, Box, Card,Grid, Typography} from '@mui/material';
import LocalPhoneIcon from '@mui/icons-material/LocalPhone';
import Button from '@mui/material/Button';
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
          <Grid container spacing={8} justifyContent="center">
           <Grid item >
              <Typography sx={{margin:"-10px 60px 0px 0px"}}>المنطقة - السبل</Typography>
            </Grid>
            <Grid item xs={2}></Grid>
          </Grid>
          <Box container sx={{margin:"40px 20px"}}>
            <Grid container spacing={8} >
            <Grid item >
               <Button variant="contained" sx={{background:"green", "&:hover": {
                  backgroundColor: "green",
                  textDecoration: "none",
                },}} ><LocalPhoneIcon /></Button>
            </Grid>
            <Grid item >
                <Button variant="contained" sx={{background:"yellow", "&:hover": {
                  backgroundColor: "yellow",
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