import React, {useState,useEffect} from 'react'
import Card from '@mui/material/Card';
import Box from '@mui/material/Box';
import Avatar from '@mui/material/Avatar';
import Modal from '@mui/material/Modal';
import Countryes from '../../Local/Data.json';
import city from '../../Local/Data.json';
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
import { useFormik } from "formik";
import * as Yup from "yup";
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
  const [imagess,setImages]=useState("");
  const [progress,setProgress] = useState(false);
  const [showTost, setShowTost] = useState(false);
  const [displayNone , setDisplayNone] = useState(true);
  const [tost, setTost] = useState({
      tostMsg: "لم يتم تحديث البيانات",
      tostType: "error",
  });
  const Openfile = (event) =>{
  const ImgeProfiles = event.target.files[0];
    const imageRef = ref(storage,`ImageTest/${ImgeProfiles.name + v4()}`);
    uploadBytes(imageRef,ImgeProfiles).then((snapshot)=>{
      setProgress(true);
      getDownloadURL(snapshot.ref).then((url)=>{
        setImages(url);
        setProgress(false);
      });
    })
    
  }
// const UpdataProfiles =  async (e) =>{
//   e.preventDefault()
//   if(name === ' '){
//   }
//     const newProfile ={
//       name : name,
//       neighborhood :neighborhood,
//       district :district,
//       typeBlood :typeBlood,
//       state :state,
//       phone :phone,
//       email :email,
//       image :imagess,
//       }
//       const userDoc = doc (db,"donors",'9U74upZiSOJugT9wrDnu');
//   updateDoc(userDoc , newProfile).then((response) =>{
//     setShowTost(true);
//     setTost({
//         tostMsg: "لقد تم تحديث البيانات بنجاح",
//         tostType: "success",
//     });
//   });
// };
const {user} =useAuthContext();

const ClickOpenFile =()=>{
  document.getElementById('uploadImage').click();
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
const formik = useFormik({
  initialValues: {
    username:  "",
    neighborhood: user.neighborhood,
    phone:user.phone,
    state:{name:"",id:""},
    district:{name:"",id:""},
    email: user.email,
    typeBlood:user.blood_type,
  },
  validationSchema: Yup.object({
    username: Yup.string()
      .max(255) 
      .required("اسم المستخدم مطلوب"),
      neighborhood: Yup.string().max(255).required("اسم المنطقة مطلوب"),
      phone: Yup.string().max(255).required("رقم التلفون مطلوب"),
      typeBlood: Yup.string().max(255).required("فصيلة الدم مطلوبة"),
  }),
  onSubmit:  (values) => {
    console.log(values);
    if(values.username === ' '){
      console.log("error upload data");
    }
      const newProfile ={
        name : values.username,
        neighborhood :values.neighborhood,
        district :values.district.name,
        typeBlood :values.typeBlood,
        state :values.state.name,
        phone :values.phone,
        email :values.email,
        image :imagess,
        }
        const userDoc = doc (db,"donors",'9U74upZiSOJugT9wrDnu');
    updateDoc(userDoc , newProfile).then((response) =>{
      setShowTost(true);
      setTost({
          tostMsg: "لقد تم تحديث البيانات بنجاح",
          tostType: "success",
      });
    });
    
  },
});
const [City, setCity] = useState([]);
const [State, setState] = useState("");
const [District,setDistrict] =useState("");
const [rowData ,setRowData] = useState([]);

useEffect(()=>{   
  const GetState = Countryes?.filter((country)=>country?.name === user?.state );
      const GetDistricts= GetState[0]?.city
     
     const GetDistrict = GetDistricts?.filter((district)=> district?.name === user?.district)|| null;
    formik.setFieldValue('username',user.name) 
    formik.setFieldValue('state',GetState[0]) 
    formik.setFieldValue('neighborhood',user.neighborhood)
    formik.setFieldValue('phone',user.phone)
    formik.setFieldValue('email',user.email)
    formik.setFieldValue('typeBlood',user.blood_type)
    formik.setFieldValue('district',GetDistrict?GetDistrict[0]:null)
   setImages(user.image);
  },[user]);
  

const HandleCountry = (event, e) => {
  const getStateid = e.id;
  const getCitydata = Countryes.find(
    (country) => country.id === getStateid
  ).city;
  setCity(getCitydata);
  formik.setFieldValue('state',e) ;
};
    const HandleState = (event,e) => {
      formik.setFieldValue('district',e) ;
      };
    return(
        <Box 
             sx={{
              marginTop:"70px" ,
              }}>
                <Grid container justifyContent="center"  >
                <Grid item md={10} xs={12}>
                <CardHeaderXs/>
                <Card sx={{p:2}}>
                     <Box sx={{display:"flex",justifyContent:"center"}}>
                         <Typography sx={{
                                   fontSize: '25px',
                                   display:{xs:"none",md:'flex'},
                                   justifyContent: 'center',
                                   marginBottom:"30px"}}>
                                  معلومات الحساب</Typography>

                      </Box>
                      <Grid 
                          container 
                          spacing={2} 
                          justifyContent="center" 
                          alignItems= 'center' 
                          flexDirection="row"> 
                      <Grid item md={3} xs={4}  >
                          {progress ? <CircularProgress/> :
                         <Avatar sx={{
                                height:{xs:"100px",md:"150px"},
                                width:{xs:"100px",md:"150px"}}} src={imagess }>   
                         </Avatar> }    
                      </Grid> 
                      <Grid item md={5} xs={8} marginTop="30px">
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
                   <Grid item md={5} xs={10.5} >
                         <TextField 
                          error={Boolean(
                            formik.touched.username && formik.errors.username
                          )}
                            name="username"
                             fullWidth 
                             helperText={formik.touched.username && formik.errors.username}
                             onBlur={formik.handleBlur}
                             onChange={formik.handleChange}
                             value={formik.values.username || ""}
                             id="outlined-basic" 
                             label="الاسم الكامل" 
                             variant="outlined" 
                            />
                    </Grid>
                  <Grid item md={5} xs={10.5}>
                         <TextField 
                               fullWidth 
                               onBlur={formik.handleBlur}
                               onChange={formik.handleChange}
                               value={formik.values.email || ""}
                            id="outlined-basic"
                            name="email"
                            label="البريد الالكتروني"
                            variant="outlined" 
                            type="email" 
                            error={Boolean(
                              formik.touched.email && formik.errors.email
                            )}
                            />
                  </Grid>
               <Grid item md={5} xs={10.5}>
                      <TextField 
                            error={Boolean(
                              formik.touched.phone && formik.errors.phone
                            )}
                            name="phone"
                               fullWidth 
                               helperText={formik.touched.phone && formik.errors.phone}
                               onBlur={formik.handleBlur}
                               onChange={formik.handleChange}
                               value={formik.values.phone || ""}
                           id="outlined-basic"
                           label="رقم الهاتف"
                         
                           variant="outlined" 
                           type="number" 
                          />
                 </Grid> 
               <Grid item md={5} xs={10.5}>
                     <Autocomplete
                     fullWidth
                     name="typeBlood"
                     value={formik.values.typeBlood || ""} 
                     options={TypeBlood}
                     onChange={(e,event) =>{ formik.setFieldValue('typeBlood',event.label)} }
                     renderInput={(params) => <TextField {...params} label="فصيلة الدم"     error={Boolean(
                      formik.touched.typeBlood && formik.errors.typeBlood
                    )} />}/>
                </Grid>
         </Grid>
         </Card> 
         </Grid>
         <Grid item md={10} xs={12}>
         <Card sx={{marginTop:"15px",paddingBottom:"20px"}}>
              <Grid container spacing={3} 
                  sx={{marginTop:"10px"}} 
                  justifyContent="center">
                    <Grid item xs={10} md={3.3}>
                     <Autocomplete
              fullWidth
              disablePortal
              name="state"
              value={formik.values.state || null}
              id="Country"
              onChange={HandleCountry}
              options={Countryes}
              getOptionLabel={(Countryes) => Countryes.name || "" }
              renderInput={(params) => (
                <TextField {...params} variant="outlined" label="المحافظة"  />
              )}
            />
                     </Grid>
                    <Grid item xs={10} md={3.3}>
                        <Autocomplete
                           fullWidth
                           disablePortal
                           id="City"
                           value={formik.values.district || null}
                           onChange={HandleState}
                           options={City}
                           getOptionLabel={(City) => City.name || "" }
                           renderInput={(params) => (
                           <TextField {...params} variant="outlined" label="المديرية"/>)}/>
                     </Grid>
                    <Grid item xs={10} md={3.3}>
                           <TextField 
                                error={Boolean(
                                  formik.touched.neighborhood && formik.errors.neighborhood
                                )}
                                name="neighborhood"
                                   fullWidth 
                                   helperText={formik.touched.neighborhood && formik.errors.neighborhood}
                                   onBlur={formik.handleBlur}
                                   onChange={formik.handleChange}
                                   value={formik.values.neighborhood || ""}
                               id="outlined-basic" 
                               label="المنطقة" 
                               variant="outlined" 
                               />
                    </Grid>
                    <Grid item xs={10} md={10}>
                          <Button 
                              fullWidth 
                              type='submit' 
                              variant="contained" 
                              onClick={formik.handleSubmit}>حفظ التعديلات</Button>
                    </Grid>
              </Grid>
         </Card>
         </Grid>
         <Grid item md={10} xs={12}>
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
                        <ModelCancle opens={open} Hand={handleClose} displayed={setDisplayNone} />
                        </Grid>
            </Grid>
            </Card> : <CardSucces  Hand={handleClose} displayed={setDisplayNone}/>}
            </Grid>
            
               <AlertSnackBar
                   open={showTost}
                   handleClose={() => setShowTost(false)}
                   message={tost.tostMsg}
                   type={tost.tostType}/> 
                   </Grid>
    </Box>
  );
};
export default Profile;
