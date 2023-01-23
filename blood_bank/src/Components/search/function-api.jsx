import React, {useState,useEffect,useRef} from 'react'
import { Box ,IconButton, Typography,Button} from '@mui/material';
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
    { label: "O-" },
    { label: "O+" },
  ];
  const style = {
    "& .css-wx798j-MuiButtonBase-root-MuiIconButton-root":{
      backgroundColor:"#f8f8f8",
      color :"black",
      fontSize :"18px",
      borderRadius :"15px",
      width:"80px",
      m:"5px",
      "&:hover":{background:"darkgray"}
    }
  }
const styleFocus = {
    backgroundColor:"white",
    color :"red",
    fontSize :"20px",
    borderRadius :"15px",
    ml:"5px",
    width:"100px",
    border:"1px solid red",
    "&:hover":{background:"#f8f8f8"
  }

};
export const FunctionApi = ({TypesBlood})=>{
  const [clickBloodType , setclickBloodType] =useState('');
  const HandleTypeBlood = (e)=>{
    setclickBloodType(e.currentTarget.value);
  }
return (
<Box sx={style}>
{ TypesBlood === "A+" ?
            Apositive.map((e,index)=>{
                                return (
                                  TypesBlood === e.label ? 
                                   <IconButton 
                                                key={index} 
                                                sx={styleFocus} 
                                                value={e.label}  
                                                onClick={HandleTypeBlood}>{e.label} 
                                          </IconButton > :<IconButton 
                                                key={index} 
                                                value={e.label}  
                                                onClick={HandleTypeBlood}>{e.label} 
                                          </IconButton > )}) :
 TypesBlood === "B+" ? 
            Bpositive.map((e,index)=>{
                                 return (<IconButton  
                                               key={index} 
                                               value={e.label}  
                                               onClick={HandleTypeBlood}>{e.label}</IconButton >)}) :
TypesBlood === "AB+" ? 
            ABpositive.map((e,index)=>{
                              return (<IconButton  
                                            key={index} 
                                            value={e.label}  
                                            onClick={HandleTypeBlood}>{e.label}
                                      </IconButton >)}) :
TypesBlood === "O+" ?
            Opositive.map((e,index)=>{
                           return (<IconButton  
                                          key={index} 
                                          value={e.label}  
                                          onClick={HandleTypeBlood}>{e.label}
                                    </IconButton >)}) : 
TypesBlood === "AB-" ? 
             ABnegative.map((e,index)=>{
                            return (<IconButton  
                                           key={index} 
                                           value={e.label}  
                                           onClick={HandleTypeBlood}>{e.label}
                                    </IconButton >)}) :
TypesBlood === "A-" ? 
            Anegative.map((e,index)=>{
                             return (<IconButton  
                                            key={index}
                                            value={e.label}  
                                            onClick={HandleTypeBlood}>{e.label}
                                      </IconButton >)}) :
TypesBlood === "B-" ? 
            Bnegative.map((e,index)=>{
                            return (<IconButton  
                                          key={index}
                                          value={e.label}  
                                          onClick={HandleTypeBlood}>{e.label}
                                    </IconButton >)}) :
TypesBlood === "O-" ? 
            Onegative.map((e,index)=>{
                        return (<IconButton  
                                      key={index}
                                      value={e.label}  
                                      onClick={HandleTypeBlood}>{e.label}
                                </IconButton >)}) : 
                          <Typography>
                                "سوف تظهر الفصائل المشابهة للفصيلة   التي تم إختيارها هنا"
                          </Typography>}
</Box>
);
}
export const SearchBloodSame = ()=>{
    return (
        <Box>

        </Box>

    );

}


  