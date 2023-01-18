import React, { useState } from "react";
import Autocomplete from "@mui/material/Autocomplete";
import TextField from "@mui/material/TextField";
import Grid from "@mui/material/Grid";
import Button from "@mui/material/Button";
import Box from "@mui/material/Grid";
import Countryes from "../../Local/Data.json";
import Paper from "@mui/material/Paper";
import CardSearch from "./card-search";
export const SearchUserBlood = () => {
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
  const [StateCityid, setStateCityid] = useState("");

  const HandleCountry = (event, e) => {
    const getStateid = e.id;
    const getCitydata = Countryes.find(
      (country) => country.id === getStateid
    ).city;
    setCity(getCitydata);
    setStateid(getStateid);
    console.log(getStateid);
  };
  const HandleState = (e) => {
    const Stateid = e.target.value;
    setStateCityid(Stateid);
  };
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
              getOptionLabel={(City) => City.name}
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
            >
              بــحــث
            </Button>
          </Grid>
        </Grid>
      <Grid
        container
        spacing={4}
        justifyContent="center"
        sx={{ marginTop: "20px" }}
      >
        <Grid item xs={10} md={3}>
          <CardSearch />
        </Grid>
        <Grid item xs={10} md={3}>
          <CardSearch />
        </Grid>
        <Grid item xs={10} md={3}>
          <CardSearch />
        </Grid>
      </Grid>
      </Paper>
    </Box>
    </>
  );
};
