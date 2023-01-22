import React, {useState,useEffect} from 'react'
import Card from '@mui/material/Card';
import Box from '@mui/material/Box';
import PersonOutlineSharpIcon from '@mui/icons-material/PersonOutlineSharp';
import { Typography } from '@mui/material';


export const CardHeaderXs =()=>{
    return (
        <Box>
            <Card 
                sx={{
                    display:{xs:"flex",md:"none"},
                    flexDirection:"row",
                    margin:"10px 0px 20px 0px",
                    p:2}}>
                <PersonOutlineSharpIcon  sx={{ fontSize:"30px"}}/>
                <Typography sx={{
                                  marginRight :"20px",
                                  fontSize: '25px',
                }}>معلومات الحساب</Typography>
            </Card>
        </Box>
    );
}