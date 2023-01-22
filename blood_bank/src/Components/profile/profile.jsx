import React, {useState,useEffect} from 'react'
import Card from '@mui/material/Card';
import Box from '@mui/material/Box';
import Avatar from '@mui/material/Avatar';
import Modal from '@mui/material/Modal';
import { ModelCancle,CardSucces } from './model-cancle';
import { CardHeaderXs } from './card-Hearder-xs';
import Imagesss from "../../Images/abdullah.jpg"
import AccountCircleSharpIcon from '@mui/icons-material/AccountCircleSharp';
import Grid from '@mui/material/Grid';
import Typography from '@mui/material/Typography';
import Button from '@mui/material/Button';
import Divider from '@mui/material/Divider';
import CardMedia from '@mui/material/CardMedia';
import  Alert  from '@mui/material/Alert';
import  CardHeader  from '@mui/material/CardHeader';
import TextField from '@mui/material/TextField';
import Autocomplete from '@mui/material/Autocomplete';
import { storage,db ,auth } from '../../utils/firebase';
import {AlertSnackBar} from '../common/alert-snackbar';
import CircularProgress from '@mui/material/CircularProgress';
import {addDoc, collection,getDocs, query, where,doc,updateDoc,getDoc,onSnapshot} from "firebase/firestore";
import {v4 } from "uuid";
import {ref,uploadBytes,listAll,getDownloadURL} from "firebase/storage";
import { Fade } from '@mui/material';
import { useAuthContext } from '../../context/auth-context';

const TypeBlood = [
    { label: 'A+'},
    { label: 'B+' },
    { label: 'AB+' },
    { label: 'O+' },
    { label: 'A-'},
    { label: 'B-' },
    { label: 'AB-'},
    { label: 'O-'},
  ];
  
 
const Profile =()=>{

  const [open, setOpen] = useState(false);
  const HandleOpen = () =>{setOpen(true);}
  const handleClose = () => setOpen(false);
  const [name , setName]=useState('');
  const [neighborhood,setNeighborhood] = useState('');
  const [email , setEmail]=useState('');
  const [typeBlood , setTypeBlood]=useState('');
  const [district , setdistrict]=useState('');
  const [phone,setPhone] = useState('');
  const [state,setState] = useState('');
  const [imageProfile , setimageProfile]=useState('');
  const [imagess,setImages]=useState('');
  const [progress,setProgress] = useState(false);
  const [showTost, setShowTost] = useState(false);
  const [displayNone , setDisplayNone] = useState(true);
  const [tost, setTost] = useState({
      tostMsg: "لم يتم تحديث البيانات",
      tostType: "error",
  });
 
const UpdataProfiles =  async (e) =>{
  e.preventDefault()
  if(name === ' '){
  }
  const userDoc = doc (db,"donors",'hzbB8GJ2VWM0bMZlo2iyxwhKvPr2');
  const newProfile ={
  name : name,
  neighborhood :neighborhood,
  district :district,
  typeBlood :typeBlood,
  state :state,
  phone :phone,
  email :email,
  image :imagess,
  }
  updateDoc(userDoc , newProfile).then((response) =>{
    setShowTost(true);
    setTost({
        tostMsg: "لقد تم تحديث البيانات بنجاح",
        tostType: "success",
    });
  });
};
const {user} =useAuthContext();

const ClickOpenFile =()=>{
  document.getElementById('uploadImage').click();
  
}
const Openfile = (event) =>{
  setimageProfile(event.target.files[0]);
  setProgress(true);
  const imageRef = ref(storage,`images/${imageProfile.name + v4()}`);
    uploadBytes(imageRef,imageProfile).then((snapshot)=>{
      getDownloadURL(snapshot.ref).then((url)=>{
        setImages(url);
        setProgress(false);
      });
    })
  
}
// const GetDataApi = async ()=>{
//   const docRef = doc(db, "donors", 'hzbB8GJ2VWM0bMZlo2iyxwhKvPr2');
//   const docSnap = await getDoc(docRef);
//   if (docSnap.exists()) {
//     console.log("Document data:", docSnap.data());
//     setName(docSnap.data().name);
//     setNeighborhood(docSnap.data().neighborhood);
//     setTypeBlood(docSnap.data().blood_type);
//     setEmail(docSnap.data().email);
//     setState(docSnap.data().state);
//     setdistrict(docSnap.data().district);
//     setPhone(docSnap.data().phone);
//     setImages(docSnap.data().image);
//     console.log(imagess);
//   }  
// }

useEffect(()=>{
 
    setImages(user.image);
    setTypeBlood(user.blood_type);
    setName(user.name);
    setEmail(user.email);
    setNeighborhood(user.neighborhood);
    setState(user.state); 
    setdistrict(user.district);
    setPhone(user.phone);
    console.log(user.id);
  },[user.blood_type]);
    return(
        <Box 
             sx={{
              marginTop:"70px" ,
              p:{xs:"20px",md:"20px"}}}>
              <Grid container spacing={2} justifyContent="center">
                    <Grid item xs={14} md={10}>
                      <CardHeaderXs/>
                         <Card
                               sx={{
                                justifyContent:"center",
                                p:3}}>
                                <Typography sx={{
                                                  fontSize: '25px',
                                                  display:{xs:"none",md:'flex'},
                                                  justifyContent: 'center',
                                                  marginBottom:"30px"}}>معلومات الحساب</Typography>
                               <Grid container spacing={4} flexDirection="row"    justifyContent="center" alignItems= 'center' >
                                           <Grid item xs={4} md={2.2} >
                                               <Avatar sx={{
                                                      height:{xs:"100px",md:"150px"},
                                                      width:{xs:"100px",md:"150px"}}} src={imagess}>
                                                      
                                               </Avatar>     
                                            </Grid>  
                      <Grid item xs={8} md={4} marginTop="30px">
                           <TextField fullWidth type='file' onChange={Openfile}
                                     sx={{display:"none"}} id="uploadImage" />
                            <Button fullWidth variant="contained" onClick={ClickOpenFile} 
                            sx={{
                              fontSize:{xs:"-0.125rem",md:"1.0rem"},
                              padding:{xs:"5px"} }} >تحديث صورة الملف الشخصي</Button>
                            <Typography color="darkgray" 
                            sx={{ 
                                  fontSize:"12px",
                                  marginRight:"20px"}}>مسموح بتنسيق jpg أو png أو GIF</Typography>
                    </Grid>
               </Grid>
         <Divider sx={{marginTop:"30px"}}/>
         <Grid container spacing={3} 
                 sx={{marginTop:"10px"}} justifyContent="center" >
                   <Grid item xs={10} md={5}>
                         <TextField 
                             fullWidth 
                             id="outlined-basic" 
                             label="الاسم الكامل" 
                             variant="outlined" 
                             value={name}
                              onChange={(event) => {setName(event.target.value);}} />
                    </Grid>
                  <Grid item xs={10} md={5}>
                         <TextField 
                            fullWidth 
                            id="outlined-basic"
                            label="البريد الالكتروني"
                            variant="outlined" 
                            type="email" 
                            value={email} 
                            onChange={(event) =>{ setEmail(event.target.value);}}/>
                  </Grid>
               <Grid item xs={10} md={5}>
                      <TextField 
                           fullWidth 
                           id="outlined-basic"
                           label="رقم الهاتف"
                           variant="outlined" 
                           type="number" 
                           value={phone} onChange={(event) =>{ setPhone(event.target.value);}}/>
                 </Grid> 
               <Grid item xs={10} md={5}>
                     <Autocomplete
                     fullWidth
                     value={typeBlood} 
                     options={TypeBlood}
                     onChange={(e,event) =>{ setTypeBlood(event.target.value);}}
                     renderInput={(params) => <TextField {...params} label="فصيلة الدم"   />}/>
                </Grid>
         </Grid>
      </Card >
      </Grid>
      <Grid item xs={14} md={10}>
         <Card sx={{marginTop:"5px",paddingBottom:"20px"}}>
              <Grid container spacing={3} 
                  sx={{marginTop:"10px"}} 
                  justifyContent="center">
                    <Grid item xs={10} md={3.3}>
                          <TextField 
                              fullWidth
                              id="outlined-basic"
                              label="المحافظة" 
                              variant="outlined" 
                              value={state} 
                              onChange={(event) =>{ setState(event.target.value);}}/>
                     </Grid>
                    <Grid item xs={10} md={3.3}>
                          <TextField 
                              fullWidth 
                              id="outlined-basic"
                              label="المديرية" 
                              variant="outlined" 
                              value={district} 
                              onChange={(event) =>{ setdistrict(event.target.value);}}/>
                     </Grid>
                    <Grid item xs={10} md={3.3}>
                           <TextField 
                               fullWidth 
                               id="outlined-basic" 
                               label="المنطقة" 
                               variant="outlined" 
                               value={neighborhood} 
                               onChange={(event) =>{ setNeighborhood(event.target.value);}} />
                    </Grid>
                    <Grid item xs={10} md={10}>
                          <Button 
                              fullWidth 
                              variant="contained" 
                              onClick={UpdataProfiles}>حفظ التعديلات</Button>
                    </Grid>
              </Grid>
         </Card>
         </Grid>
         <Grid item xs={14} md={10}>
          {displayNone ? 
            <Card sx={{marginTop:"10px",p:1}}>
                    <CardHeader 
                         title="إلغاء تنشيط عملية التبرع" 
                         sx={{marginRight:"70px"}}/>
                       <Grid container spacing={2} justifyContent="center" >
                              <Grid item xs={10} md={10}  
                                 sx={{
                                      "& .css-wg9czh-MuiPaper-root-MuiAlert-root":
                                        {color:"red"}
                                    }} >
                             <Alert 
                                  icon={false} 
                                  severity="warning">هل أنت متأكد من عملية الإلغاء؟ <br/>سيتم تعطيل حسابك ولن تظهر بياناتك عندما يتم البحث عن متبرع</Alert>  
                              </Grid>
                        <Grid item xs={10} md={10}>
                               <Button 
                                   fullWidth 
                                   variant="contained" 
                                   color="error" 
                                   onClick={HandleOpen}>
                                إلغاء تنشيط عملية التبرع</Button>    
                        </Grid> 
                        <Grid item  xs={10} md={10}>
                        <ModelCancle opens={open} Hand={handleClose} displayed={setDisplayNone}/>
                        </Grid>
            </Grid>
            </Card> : <CardSucces  Hand={handleClose} displayed={setDisplayNone}/>}
            </Grid>
            </Grid>
               <AlertSnackBar
                   open={showTost}
                   handleClose={() => setShowTost(false)}
                   message={tost.tostMsg}
                   type={tost.tostType}/> 
    </Box>
  );
};
export default Profile;

