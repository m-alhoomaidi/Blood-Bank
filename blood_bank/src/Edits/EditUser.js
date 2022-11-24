import * as React from 'react';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import Container from '@mui/material/Container';
import Card1 from './Card1';
import Card2 from './Card2';
export default function EditUser() {
  return (
    <Container>
    <Box >
    <Grid container spacing={3}   sx={{marginTop:"-170px",justifyContent:"center"}}>
      <Card1/>
      <Card2/>

</Grid>       
    </Box>
    </Container>
  );
};