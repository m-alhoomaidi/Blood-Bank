import React, { useState } from 'react';
import { Avatar, Box, Card, CardContent, Grid, Typography,Fab,Collapse,CardActions, CardHeader } from '@mui/material';
import IconButton from '@mui/material/IconButton';
import LocalPhoneIcon from '@mui/icons-material/LocalPhone';
import Button from '@mui/material/Button';
import MessageIcon from '@mui/icons-material/Message';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { styled } from '@mui/material/styles';
const CardSearch = (props) => {    
    const [expanded, setExpanded] =useState(false);
    const handleExpandClick = () => {
      setExpanded(!expanded);
    };
    return (
    <Box container>
  <Card
    sx={{ height: '100%' }}
    {...props}
  >
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
      <Button variant="contained" sx={{background:"green"}} ><LocalPhoneIcon /></Button>
        </Grid>
        <Grid item >
      <Button variant="contained" sx={{background:"yellow"}}><MessageIcon /></Button>
        </Grid>
        </Grid>
        </Box>
  </Card>
  </Box>
    );
};
export default CardSearch;