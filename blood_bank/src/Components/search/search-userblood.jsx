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
import { NotFoundData } from "./not-fondData";
import CardSearch from "./card-search";
import { db } from "../../utils/firebase";
import Tab from '@mui/material/Tab';
import TabContext from '@mui/lab/TabContext';
import TabList from '@mui/lab/TabList';
import TabPanel from '@mui/lab/TabPanel';
import { collection, getDocs, query, where } from "firebase/firestore";
import { FunctionApi, TypeBlood, SearchBloodSame, Apositive, Bpositive, ABpositive, Opositive, ABnegative, Anegative, Bnegative, Onegative, style, styleFocus } from "./function-api";
import { Grow, IconButton, Typography } from "@mui/material";
import CardSearchCenter from "./card-search-center";
import SearchCenter from "./searchCenter";
import { useAuthContext } from "../../context/auth-context";
export const SearchUserBlood = () => {
  const { searchUser } = useAuthContext();
  const [searchBlood, setsearchBlood] = useState([]);
  const [searchBloodCenter, setsearchBloodCenter] = useState([]);
  const [district, setdistrict] = useState('');
  const [NotData, setNotData] = useState(false);
  const [typeBlood, setTypeBlood] = useState();
  const [Transion, setTransion] = useState(false);
  const [Progress, setProgress] = useState(false);
  const [BloodIconShow, setBloodIconShow] = useState(false);
  const [state, setState] = useState('');
  const SearhBloold = async () => {
    setProgress(true);
    const docRf = query(
      collection(db, "donors"),
      where("blood_type", "==", typeBlood),
      where("state", "==", state),
      where("district", "==", district),
    );

    getDocs(docRf).then((response) => {
      const DataUser = response.docs.map((doc) => ({ data: doc.data(), id: doc.id }));
      setsearchBlood(DataUser);
      setProgress(false);
      searchUser(DataUser);
    })
    const docRfCenter = query(
      collection(db, "centers"),
      where("state", "==", state),
      where("district", "==", district),
    );

    getDocs(docRfCenter).then((response) => {
      const DataCenter = response.docs.map((doc) => ({ data: doc.data() }));
      setsearchBloodCenter(DataCenter);
      console.log(DataCenter);
    })

  }

  const [Stateid, setStateid] = useState([]);
  const [City, setCity] = useState([]);
  const [ClickIcon, setClickIcon] = useState(false);
  const [value, setValue] = useState('1');

  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  const HandleCountry = (event, e) => {
    const getStateid = e.id;
    const getCitydata = Countryes.find(
      (country) => country.id === getStateid
    ).city;
    setCity(getCitydata);
    setStateid(getStateid);
    setState(e.name);
  };
  const HandleState = (event, e) => {
    setdistrict(e.name);
  };
  const HandleBloodType = (event, e) => { setTypeBlood(e.label); setTransion(true); setBloodIconShow(true); }
  const [clickBloodType, setclickBloodType] = useState("");
  const HandleTypeBlood = (e) => {
    setclickBloodType(e.currentTarget.value);
    setClickIcon(true);
  }
  return (
    <>
      <Box sx={{ marginTop: "80px", p: 3 }}>
        <Paper
          sx={{
            p: 2,
            margin: "auto",
            flexGrow: 1,
            boxShadow: "0px 0px 0px",
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
                sx={{ marginTop: "10px" }}
                onClick={SearhBloold}
              >
                بــحــث
              </Button>
            </Grid>
          </Grid>
          <Grid container justifyContent="center" flexDirection="row" mt="30px">
            <Grid item xs={10} md="auto">
              {BloodIconShow ?
                <Card sx={{ display: "flex", justifyContent: "center", flexDirection: "row", p: 3, marginTop: "10px", boxShadow: "5px 5px 5px rgb(100 116 139 / 6%),5px 5px 20px rgb(100 116 139 / 10%)" }}>
                  {Transion ?
                    <Grow
                      in={Transion}
                      style={{ transformOrigin: '2 2 2' }}
                      {...(Transion ? { timeout: 2000 } : {})}>
                      <Box sx={style}>
                        {typeBlood === "A+" ?
                          Apositive.map((e, index) => {
                            return (
                              <IconButton
                                key={index}
                                sx={typeBlood === e.label ? styleFocus :null}
                                value={e.label}
                                onClick={HandleTypeBlood}>{e.label}
                              </IconButton >)
                          }) :
                          typeBlood === "B+" ?
                            Bpositive.map((e, index) => {
                              return (
                                <IconButton
                                  key={index}
                                  sx={typeBlood === e.label ? styleFocus : null}
                                  value={e.label}
                                  onClick={HandleTypeBlood}>{e.label}
                                </IconButton >)
                            }) :
                            typeBlood === "AB+" ?
                              ABpositive.map((e, index) => {
                                return (
                                  <IconButton
                                    key={index}
                                    sx={typeBlood === e?.label ? styleFocus : null}
                                    value={e.label}
                                    onClick={HandleTypeBlood}>{e.label}
                                  </IconButton >)
                              }) :
                              typeBlood === "O+" ?
                                Opositive.map((e, index) => {
                                  return (
                                    <IconButton
                                      key={index}
                                      sx={typeBlood === e.label ? styleFocus : null}
                                      value={e.label}
                                      onClick={HandleTypeBlood}>{e.label}
                                    </IconButton >)
                                }) :
                                typeBlood === "AB-" ?
                                  ABnegative.map((e, index) => {
                                    return (
                                      <IconButton
                                        key={index}
                                        sx={typeBlood === e.label ? styleFocus : null}
                                        value={e.label}
                                        onClick={HandleTypeBlood}>{e.label}
                                      </IconButton >)
                                  }) :
                                  typeBlood === "A-" ?
                                    Anegative.map((e, index) => {
                                      return (
                                        <IconButton
                                          key={index}
                                          sx={typeBlood === e.label ? styleFocus : null}
                                          value={e.label}
                                          onClick={HandleTypeBlood}>{e.label}
                                        </IconButton >)
                                    }) :
                                    typeBlood === "B-" ?
                                      Bnegative.map((e, index) => {
                                        return (
                                          <IconButton
                                            key={index}
                                            sx={typeBlood === e.label ? styleFocus : null}
                                            value={e.label}
                                            onClick={HandleTypeBlood}>{e.label}
                                          </IconButton >)
                                      }) :
                                      typeBlood === "O-" ?
                                        Onegative.map((e, index) => {
                                          return (
                                            <IconButton
                                              key={index}
                                              sx={typeBlood === e.label ? styleFocus : null}
                                              value={e.label}
                                              onClick={HandleTypeBlood}>{e.label}
                                        </IconButton >
                                      )
                                    }
                              ) : ""
                            }
                      </Box>
                    </Grow>
                    : ""}
                </Card>
                : ""}
            </Grid>
          </Grid>
        </Paper>
        <Box sx={{ width: '100%', typography: 'body1' }}>
          <TabContext value={value}>
            <Box sx={{ borderBottom: 1, borderColor: 'divider', display: "flex", justifyContent: "center" }}>
              <TabList onChange={handleChange} aria-label="lab API tabs example">
                <Tab label="نتائج البحث من المتبرعين" value="1" sx={{ marginLeft: "100px" }} />
                <Tab label=" نتائج البحث من المراكز الطبية" value="2" sx={{ marginRight: "50xp" }} />
              </TabList>
            </Box>
            <TabPanel value="1"> <Grid
              container
              spacing={3}
              sx={{ marginTop: "40px", justifyContent: "center" }}
            > {Progress ? <CircularProgress /> :
              ClickIcon ? <Grid item xs={10} md={3.5} >
                <FunctionApi TypesBlood={clickBloodType} searchSameBlood={searchBlood} />
              </Grid> :
                <Grid item xs={10} md={3.5} >{
                  searchBlood.map((user, index) => {
                    return (
                      user.data.is_shown === "1" ?
                        <CardSearch
                          nameSearch={user.data.name}
                          bloodType={user.data.blood_type}
                          neighborhood={user.data.neighborhood}
                          sx={{ margin: "10px", p: 2 }}
                          key={index} /> : "");})}
                </Grid>}
            </Grid></TabPanel>
            <TabPanel value="2"> <Grid
              container
              spacing={3}
              sx={{ marginTop: "40px", justifyContent: "center" }}
            > <Grid item xs={10} md={4} ><SearchCenter resultSearchCenter={searchBloodCenter} BloodType={typeBlood} /></Grid></Grid></TabPanel>
          </TabContext>
        </Box>
      </Box>
    </>
  );
};
