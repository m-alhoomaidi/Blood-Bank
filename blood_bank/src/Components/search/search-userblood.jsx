import React, { useEffect, useState } from "react";
import Autocomplete from "@mui/material/Autocomplete";
import TextField from "@mui/material/TextField";
import Grid from "@mui/material/Grid";
import Button from "@mui/material/Button";
import Box from "@mui/material/Grid";
import Countryes from "../../Local/Data.json";
import Paper from "@mui/material/Paper";
import {NotFoundData} from "./not-fondData";
import CardSearch from "./card-search";
import {db } from "../../utils/firebase";
import {collection,getDocs, query, where} from "firebase/firestore";
export const SearchUserBlood = () => {
  
  const [searchBlood,setsearchBlood] =useState([]);
  const [district,setdistrict] = useState('');
  const [NotData,setNotData] = useState(false);
  const [typeBlood , setTypeBlood]=useState('');
  const [state,setState] = useState('');
  const SearhBloold = async ()=>{
    const docRf = query(
      collection(db, "donors"),
      where("blood_type", "==",typeBlood),
      where("state", "==",state),
     where("district","==",district), 
  );
  
  getDocs(docRf).then((response) =>{
    const DataUser = response.docs.map((doc) => ({data:doc.data(),id : doc.id}));
    setsearchBlood(DataUser);
    setNotData(true);
  })
  
    }
  const TypeBlood = [
    { label: "A+" },
    { label: "B+" },
    { label: "AB+" },
    { label: "O+" },
    { label: "A-" },
    { label: "B-" },
    { label: "AB-" },
    { label: "O-" },
  ];
  const [Stateid, setStateid] = useState([]);
  const [City, setCity] = useState([]);

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
  return (
    <>
    <Box  sx={{ marginTop: "80px" }}>
      <Paper
        sx={{
          p: 4,
          margin: "auto",
          flexGrow: 1,
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
      <Grid
        container
        spacing={4}
        sx={{ marginTop: "20px",justifyContent:"center" }}
      > {NotData ?  searchBlood.map((user,index)=>{
        return(
          <Grid item xs={10} md={3} key={index} >
          <CardSearch nameSearch={user.data.name} bloodType={user.data.blood_type} neighborhood={user.data.neighborhood} sx={{margin:"10px"}} key={user.id}/>
          </Grid> );}) : <NotFoundData/> }
        
      </Grid>
      </Paper>
    </Box>
    </>
  );
};
