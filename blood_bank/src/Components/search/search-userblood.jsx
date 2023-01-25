import React, { useEffect, useState } from "react";
import Autocomplete from "@mui/material/Autocomplete";
import TextField from "@mui/material/TextField";
import Grid from "@mui/material/Grid";
import Button from "@mui/material/Button";
import Card from "@mui/material/Card";
import Box from "@mui/material/Grid";
import Countryes from "../../Local/Data.json";
import Paper from "@mui/material/Paper";
import CircularProgress from '@mui/material/CircularProgress';
import {NotFoundData} from "./not-fondData";
import CardSearch from "./card-search";
import {db } from "../../utils/firebase";
import {collection,getDocs, query, where} from "firebase/firestore";
import { FunctionApi, TypeBlood,SearchBloodSame, Apositive, Bpositive, ABpositive, Opositive, ABnegative, Anegative, Bnegative, Onegative, style, styleFocus } from "./function-api";
import { IconButton, Typography } from "@mui/material";
export const SearchUserBlood = () => {
  
  const [searchBlood,setsearchBlood] =useState([]);
  const [district,setdistrict] = useState('');
  const [NotData,setNotData] = useState(false);
  const [typeBlood , setTypeBlood]=useState('');
  const [sameBlood , setsameBlood]=useState('');
  const [Progress,setProgress]=useState(false);
  const [state,setState] = useState('');
  const SearhBloold = async ()=>{
    setProgress(true);
    const docRf = query(
      collection(db, "donors"),
      where("blood_type", "==",typeBlood),
      where("state", "==",state),
     where("district","==",district), 
  );
  
  getDocs(docRf).then((response) =>{
    const DataUser = response.docs.map((doc) => ({data:doc.data(),id : doc.id}));
    setsearchBlood(DataUser);
    setProgress(false);
    setNotData(true);
  })
  
    }
  
  const [Stateid, setStateid] = useState([]);
  const [City, setCity] = useState([]);
const [ClickIcon ,setClickIcon]=useState(false);


  const HandleCountry = (event, e) => {
    const getStateid = e.id;
    const getCitydata = Countryes.find(
      (country) => country.id === getStateid
    ).city;
    setCity(getCitydata);
    setStateid(getStateid);
    setState(e.name);
  };
  const HandleState = (event,e) => {
    setdistrict(e.name);
  };
     const HandleBloodType=(event,e)=>{setTypeBlood(e.label);}
     const [clickBloodType , setclickBloodType] =useState("");
     const HandleTypeBlood = (e)=>{
       setclickBloodType(e.currentTarget.value);
       setClickIcon(true);
     }
  return (
    <>
    <Box  sx={{ marginTop: "80px",p:3 }}>
      <Paper
        sx={{
          p:2,
          margin: "auto",
          flexGrow: 1,
          boxShadow:"0px 0px 0px",
          backgroundColor: (theme) =>
            theme.palette.mode === "dark" ? "#1A2027" : "#fff",
        }}
      >
        <Grid container spacing={3} flexDirection="row" justifyContent="center">
          <Grid item xs={10} md={3}>
            <Autocomplete
              fullWidth
              disablePortal
              id="Country"
              onChange={HandleCountry}
              options={Countryes}
              getOptionLabel={(Countryes) => Countryes.name}
              renderOption={(props, option) => (
                <Box component="li" key={option.id} {...props}>
                  {option.name}
                </Box>
              )}
              renderInput={(params) => (
                <TextField {...params} variant="outlined" label="المحافظة" />
              )}
            />
          </Grid>
          <Grid item xs={10} md={3}>
            <Autocomplete
              fullWidth
              disablePortal
              id="City"
              onChange={HandleState}
              options={City}
              getOptionLabel={(City) => City.name }
              renderOption={(props, option) => (
                <Box component="li" key={option.id} {...props}>
                  {option.name}
                </Box>
              )}
              renderInput={(params) => (
                <TextField {...params} variant="outlined" label="المديرية" />
              )}
            />
          </Grid>
          <Grid item xs={10} md={3}>
            <Autocomplete
              fullWidth
              disablePortal
              onChange={HandleBloodType}
              id="combo-box-demo"
              options={TypeBlood}
              renderInput={(params) => (
                <TextField {...params} label="فصيلة الدم" variant="outlined" />
              )}
            />
          </Grid>
          <Grid item xs={10} md={2}> 
            <Button
              variant="contained"
              fullWidth
              sx={{marginTop:"10px"}}
              onClick={SearhBloold}
            >
              بــحــث
            </Button>
          </Grid>       
          </Grid>
          <Grid container justifyContent="center" flexDirection="row" mt="30px">
        <Grid item xs={10} md="auto">
        <Card sx={{display:"flex",justifyContent:"center",flexDirection:"row",p:3,marginTop:"20px",boxShadow: "5px 5px 5px rgb(100 116 139 / 6%),5px 5px 20px rgb(100 116 139 / 10%)"}}>
        <Box sx={style}>
{ typeBlood === "A+" ?
            Apositive.map((e,index)=>{
                                return (
                                  typeBlood === e.label ? 
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
 typeBlood === "B+" ? 
            Bpositive.map((e,index)=>{
                                 return ( typeBlood === e.label ? 
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
typeBlood === "AB+" ? 
            ABpositive.map((e,index)=>{
                              return ( typeBlood === e.label ? 
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
typeBlood === "O+" ?
            Opositive.map((e,index)=>{
                           return ( typeBlood === e.label ? 
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
typeBlood === "AB-" ? 
             ABnegative.map((e,index)=>{
                            return ( typeBlood === e.label ? 
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
typeBlood === "A-" ? 
            Anegative.map((e,index)=>{
                             return ( typeBlood === e.label ? 
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
typeBlood === "B-" ? 
            Bnegative.map((e,index)=>{
                            return ( typeBlood === e.label ? 
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
typeBlood === "O-" ? 
            Onegative.map((e,index)=>{
                        return ( typeBlood === e.label ? 
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
                          <Typography>
                                "سوف تظهر الفصائل المشابهة للفصيلة   التي تم إختيارها هنا"
                          </Typography>}
</Box>
        </Card>
        </Grid>
        </Grid>
      </Paper>
      <Grid
        container
        spacing={3}
        sx={{ marginTop: "40px",justifyContent:"center" }}
      > {Progress?    <CircularProgress/>
                 : ClickIcon ?  <Grid item xs={10} md={3} >
               <FunctionApi  TypesBlood={clickBloodType} searchSameBlood={searchBlood}/>
               </Grid> :
                <Grid item xs={10} md={3} >
                {
                                      searchBlood.map((user,index)=>{
                                       return ( 
                                        user.data.is_shown === "1" ?
                                       <CardSearch nameSearch={user.data.name} bloodType={user.data.blood_type} neighborhood={user.data.neighborhood} sx={{margin:"10px"}} key={index} />:"" );
                                       })}
                </Grid> }
         
      </Grid>
    </Box>
    </>
  );
};
