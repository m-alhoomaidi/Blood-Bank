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
    <Box container sx={{ marginTop: "80px" }}>
      <Paper
        sx={{
          p: 2,
          margin: "auto",
          flexGrow: 1,
          backgroundColor: (theme) =>
            theme.palette.mode === "dark" ? "#1A2027" : "#fff",
        }}
      >
        <Grid container spacing={3} justifyContent="center">
          <Grid item>
            <Autocomplete
              fullWidth
              disablePortal
              id="Country"
              onChange={HandleCountry}
              options={Countryes}
              getOptionLabel={(Countryes) => Countryes.name}
              sx={{ width: 300 }}
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
          <Grid item>
            <Autocomplete
              fullWidth
              disablePortal
              id="City"
              onChange={HandleState}
              options={City}
              getOptionLabel={(City) => City.name}
              sx={{ width: 300 }}
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
          <Grid item>
            <Autocomplete
              fullWidth
              disablePortal
              id="combo-box-demo"
              options={TypeBlood}
              sx={{ width: 300 }}
              renderInput={(params) => (
                <TextField {...params} label="فصيلة الدم" variant="outlined" />
              )}
            />
          </Grid>
          <Grid item>
            <Button
              variant="contained"
              sx={{ width: "150px", marginTop: "8px" }}
            >
              بــحــث
            </Button>
          </Grid>
        </Grid>
      </Paper>
      <Grid
        container
        spacing={3}
        justifyContent="center"
        sx={{ marginTop: "20px" }}
      >
        <Grid item>
          <CardSearch />
        </Grid>
        <Grid item>
          <CardSearch />
        </Grid>
        <Grid item>
          <CardSearch />
        </Grid>
      </Grid>
    </Box>
  );
};
