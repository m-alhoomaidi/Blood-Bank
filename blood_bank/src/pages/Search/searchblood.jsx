import * as React from 'react';
import Card from '@mui/material/Card';
import Autocomplete from '@mui/material/Autocomplete';
 import CardSearch from './SearchCard';
import LottieApp from "../../Components/lottie";
import {
  LOGO_LOTTIE,
} from '../../constant/media';
import ImgesBackGroud from '../../Images/BackGround.jpg';
import {
    Typography,
    Button,
    Box,
    Grid,
    InputAdornment,
    TextField,
} from "@material-ui/core";
import AddLocationIcon from '@mui/icons-material/AddLocation';
import LocationOnIcon from '@mui/icons-material/LocationOn';
import BloodtypeIcon from '@mui/icons-material/Bloodtype';

export default function Search() {
    const top100Films1 = [
        { label: 'Ibb' },
        { label: 'Taiz' },
        { label: 'Aden' },
        { label: 'Sana`a' },
        { label: 'Theamar' },
        { label: 'Marib' },
        { label: 'Hudidah' },
        { label: 'Al-Mokala' },
    ];
    return (
        <Box>
        <Box sx={{backgroundImage: `url(${ImgesBackGroud})`,backgroundSize:"cover",'& .MuiGrid-spacing-xs-3': {width: 'calc(100% + -14px)',margin: '-40px 15px 15px 15px',height:"100%",'& .css-fy33mm-MuiPaper-root-MuiCard-root':{
            marginTop :"30px"}}}}>
                <Box sx={{display : "flex",justifyContent : "center",marginTop:"30px"}}>
                <Box sx={{marginTop:"20px"}}><Typography variant="h4">البحث عن متبرع...</Typography></Box>
                <Box sx={{cursor: "pointer",position :"relative",width: "150px",height: "150px",}}><LottieApp animationpath={LOGO_LOTTIE} />
                </Box>
                </Box>
                <Grid container spacing={3} justifyContent="center">
                    <Grid item>
                    <Autocomplete
                            id="ckeckboxes-tags-demo"
                            options={top100Films1}
                            disableClearable
                            sx={{
                                '& .css-1q60rmi-MuiAutocomplete-endAdornment': {
                                    position: 'relative',
                                    right: '0px'},'& .MuiSvgIcon-root': {
                                    marginLeft: '10px'}}}
                            renderInput={(params) => {
                                const InputProps = {
                                    ...params.InputProps,
                                    style: { color: "black", fontWeight: 'bold',fontSize: '1.2rem',marginLeft: '50px'},
                                    startAdornment: (
                                        <InputAdornment position="start">
                                            < AddLocationIcon />
                                        </InputAdornment>)};
                                return (
                                    <TextField
                                        required
                                        placeholder="المحافظة"
                                        variant="outlined"
                                        {...params}
                                        InputProps={InputProps}/>);}}/>
                    </Grid>
                    <Grid item  >
                        <Autocomplete
                            id="ckeckboxes-tags-demo"
                            options={top100Films1}
                            disableClearable
                            sx={{
                                '& .css-1q60rmi-MuiAutocomplete-endAdornment': {
                                    position: 'relative',
                                    right: '0px'},'& .MuiSvgIcon-root': {
                                    marginLeft: '10px'}}}
                            renderInput={(params) => {
                                const InputProps = {
                                    ...params.InputProps,
                                    style: { color: "black", fontWeight: 'bold',fontSize: '1.2rem',marginLeft: '50px'},
                                    startAdornment: (
                                        <InputAdornment position="start">
                                            < LocationOnIcon />
                                        </InputAdornment>)};
                                return (
                                    <TextField
                                        required
                                        placeholder="المديـريـة"
                                        variant="outlined"
                                        {...params}
                                        InputProps={InputProps}/>);}}/>
                    </Grid>
                    <Grid item>
                        <Autocomplete
                            id="ckeckboxes-tags-demo"
                            options={top100Films1}
                            disableCloseOnSelect
                            disableClearable
                            sx={{
                                '& .css-1q60rmi-MuiAutocomplete-endAdornment': {
                                    position: 'relative',
                                    right: '0px',
                                },
                                '& .MuiSvgIcon-root': {
                                    marginLeft: '10px'},}}
                            renderInput={(params) => {
                                const InputProps = {
                                    ...params.InputProps,
                                    style: {color: "black",fontWeight: 'bold', fontSize: '1.2rem',
                                        marginLeft: '60px',
                                    },
                                    startAdornment: (
                                        <InputAdornment position="start">
                                            < BloodtypeIcon />
                                        </InputAdornment>
                                    ),
                                };
                                return (
                                    <TextField
                                        required
                                        placeholder="فصيلة دمك ؟"
                                        variant="outlined"
                                        {...params}
                                        InputProps={InputProps}/>);}}/>
                    </Grid>
                </Grid>
               
                <Box sx={{display:"flex",justifyContent:"center"}}>
                    <Typography variant="h4"> تظهر الفصائل المطابقة للفصيلة التي تم اختيارها هنا</Typography>
                     {/* <Grid container spacing={3} justifyContent="center">
                    <Grid item xs={2} md={2}>
                        <Card sx={{textAlign:"center"}}>
                            A+
                        </Card>
                    </Grid>
                    <Grid item xs={2} md={2}>
                        <Card sx={{textAlign:"center"}}>
                            O+
                        </Card>
                    </Grid>
                    <Grid item xs={2} md={2}>
                        <Card sx={{textAlign:"center"}}>
                            O-
                        </Card>
                    </Grid>
                </Grid> */}
                </Box>
                <Box sx={{display:"flex",justifyContent:"center",'& .MuiButton-contained':{
                        color :"black",
                        background:"#f44336",
                        width :"30%",
                        borderRadius:"20px",
                        fontSize :'20px',
                        }}}>
                <Button variant="contained" disableElevation>بــحــث</Button>
                </Box>  
                <Box sx={{'& .css-zwt9xa-MuiPaper-root-MuiCard-root':{
                    margin :"20px",
                }}}>
                <Grid container  justifyContent="center">
                    <Grid item sx={{marginLeft :'10px'}}>
                        <CardSearch/>
                    </Grid>
                    <Grid item >
                        <CardSearch/>
                    </Grid>
                    <Grid item >
                        <CardSearch/>
                    </Grid>
                </Grid>
                </Box>
        </Box>
    </Box>
    );
};