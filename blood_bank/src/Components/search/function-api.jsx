import React, {useState,useEffect,useRef} from 'react'
import { Box ,IconButton, Typography,Button} from '@mui/material';
import CardSearch from './card-search';
import { NotFoundData } from './not-fondData';
export const TypeBlood = [
    { label: "A+" },
    { label: "B+" },
    { label: "AB+" },
    { label: "O+" },
    { label: "A-" },
    { label: "B-" },
    { label: "AB-" },
    { label: "O-" },
  ];
export const Apositive = [
    { label: "A+" },
    { label: "O+" },
    { label: "A-" },
    { label: "O-" },
  ];
  export const Bpositive = [
    { label: "B+" },
    { label: "B-" },
    { label: "O+" },
    { label: "O-" },
  ];
  export const Anegative = [
    { label: "A-" },
    { label: "O-" },
  ];
  export const Bnegative = [
    { label: "B-" },
    { label: "O-" },
  ];
  export const ABpositive = [
    { label: "AB+" },
    { label: "AB-" },
    { label: "A+" },
    { label: "A-" },
    { label: "B+" },
    { label: "B-" },
    { label: "O-" },
    { label: "O+" },
  ];
  export const ABnegative = [
    { label: "AB-" },
    { label: "A-" },
    { label: "B-" },
    { label: "O-" },
  ];
  export const Onegative = [
    { label: "O-" },
  ];
  export const Opositive = [
    { label: "O+" },
    { label: "O-" },
  ];
  export const style = {
    "& .css-wx798j-MuiButtonBase-root-MuiIconButton-root":{
      backgroundColor:"#f8f8f8",
      color :"black",
      fontSize :"18px",
      borderRadius :"15px",
      width:"80px",
      mt:"8px",
      ml:"2px",
      "&:hover":{ 
      backgroundColor:"white",
      color :"red",
      fontSize :"20px",
      borderRadius :"15px",
      ml:"5px",
      width:"100px",
      border:"1px solid red",
      "&:hover":{background:"#f8f8f8"},
    }
  }
}

  