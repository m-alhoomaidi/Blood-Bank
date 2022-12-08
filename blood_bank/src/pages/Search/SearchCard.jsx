import React, { useState } from 'react';
import { Avatar, Box, Card, CardContent, Grid, Typography,Fab,Collapse,CardActions } from '@mui/material';
import IconButton from '@mui/material/IconButton';
import LocalPhoneIcon from '@mui/icons-material/LocalPhone';
import MessageIcon from '@mui/icons-material/Message';
import ExpandMoreIcon from '@mui/icons-material/ExpandMore';
import { styled } from '@mui/material/styles';
const ExpandMore = styled((props) => {
    const { expand, ...other } = props;
    return <IconButton {...other} />;
  })(({ theme, expand }) => ({
    transform: !expand ? 'rotate(0deg)' : 'rotate(180deg)',
    marginLeft: 'auto',
    marginTop :'-30px',
    transition: theme.transitions.create('transform', {
      duration: theme.transitions.duration.shortest,
    }),
  }));
const CardSearch = (props) => {    
    const [expanded, setExpanded] =useState(false);
    const handleExpandClick = () => {
      setExpanded(!expanded);
    };
    return (
    <Box>
  <Card
    sx={{ height: '100%' }}
    {...props}
  >
    <CardContent>
      <Grid
        container
        spacing={3}
        sx={{ justifyContent: 'space-between',
    '& .css-chjbjb-MuiTypography-root':{
        fontSize: '1.75rem',
        color :"black",
    } }}
      >
        <Grid item>
          <Typography
            color="textSecondary"
            gutterBottom
            variant="overline"
          >
           علي
          </Typography>
          <Typography
            color="textPrimary"
            variant="h5"
          >
            المنطقة - الظهار
          </Typography>
        </Grid>
        <Grid item>
          <Avatar
            sx={{
              backgroundColor: 'error.main',
              height: 56,
              width: 56,
              
            }}
          >
            A+
          </Avatar>
        </Grid>
      </Grid>
    </CardContent>
    <CardActions disableSpacing >
        <ExpandMore
          expand={expanded} 
          onClick={handleExpandClick}
          aria-expanded={expanded}
          aria-label="show more">
          <ExpandMoreIcon/>
        </ExpandMore>
      </CardActions>
      <Collapse in={expanded} timeout="auto" unmountOnExit>
        <CardContent>
        <Box
        sx={{
          pt: 1,
          display: 'flex',
          alignItems: 'center','& .css-mm42gz-MuiButtonBase-root-MuiFab-root':{
            background :'yellow'
           }
        }}
      >
       <Fab color="green" aria-label="add" sx={{marginTop :"-30px",marginRight:"20px"}}>
        <LocalPhoneIcon />
      </Fab>
      <Fab color="yellow" aria-label="add" style={{marginTop :"-30px",marginRight:"20px"}}>
        <MessageIcon />
      </Fab>
      </Box>
    </CardContent>
      </Collapse>
  </Card>
  </Box>
    );
};
export default CardSearch;