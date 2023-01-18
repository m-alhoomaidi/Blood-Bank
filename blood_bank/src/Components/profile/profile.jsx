import React, {useState,useEffect} from 'react'
import Card from '@mui/material/Card';
import Box from '@mui/material/Box';
import Avatar from '@mui/material/Avatar';
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
import { storage,db } from '../../utils/firebase';


import {addDoc, collection,getDocs, query, where,doc,updateDoc} from "firebase/firestore";
import { useAuthContext } from '../../context/auth-context';
import {v4 } from "uuid";
import {ref,uploadBytes,listAll,getDownloadURL} from "firebase/storage";

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
  
  const ClickOpenFile =()=>{
    document.getElementById('uploadImage').click();
  }
const Profile =()=>{
  const [name , setName]=useState('');
  const [neighborhood,setNeighborhood] = useState('');
  const [email , setEmail]=useState('');
  const [id , setId]= useState('');
  const [typeBlood , setTypeBlood]=useState('');
  const [district , setdistrict]=useState('');
  const [phone,setPhone] = useState('');
  const [state,setState] = useState('');
  const [imageProfile , setimageProfile]=useState('');
  const [ImagesList,setImagesList]=useState([]);

  const Openfile = (event) =>{
    const FileImage=URL.createObjectURL(event.target.files[0]);
    setState(FileImage);
    setimageProfile(event.target.files[0]);
  }
  // const uploadimages = () =>{
  //   const imageRef = ref(storage,`images/${imageProfile.name + v4()}`);
  //   uploadBytes(imageRef,imageProfile).then((snapshot)=>{
  //     getDownloadURL(snapshot.ref).then((url)=>{
  //       setImagesList([url])
  //     });
  //     alert('True Upload image');
  //   })
  // } 
  // const ImageListRef =ref(storage,"images");
  // const ImageList = () =>{
  //   listAll(ImageListRef).then((respones)=>{
  //     respones.items.forEach((item)=>{
  //       getDownloadURL(item).then((url)=>{
  //         setImagesList([url]);
  //       });
  //     });
  //   });
  // }
  const { user } = useAuthContext();
const UpdataProfiles =  async (e) =>{
  e.preventDefault()
  if(name === ' '){
    console.log('no conecct');
  }
  const userDoc = doc (db,"test", id);
  const newProfile ={
  name : name,
  }
  updateDoc(userDoc , newProfile);
};
  useEffect(()=>{
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
        <Box sx={{marginTop:"70px" ,p:{xs:"0px",md:"20px"}}}>
          <Grid container spacing={2} justifyContent="center">
            <Grid item xs={14} md={10}>
          <Card
        sx={{
          justifyContent:"center",
          p:3}}>
            <Typography sx={{fontSize: '25px',display:'flex',
    justifyContent: 'center',marginBottom:"30px"}}>معلومات الحساب</Typography>
          <Grid container spacing={4} flexDirection="row" justifyContent="center" alignItems= 'center' >
            <Grid item xs={4} md={3} >
                    <Avatar sx={{height:{xs:"100px",md:"150px"},width:{xs:"100px",md:"150px"}}}> <CardMedia component='img'  image={Imagesss} height="180" /></Avatar>     
            </Grid>
            <Grid item xs={8} md={4} marginTop="30px">
              <TextField fullWidth type='file' onChange={Openfile} sx={{display:"none"}} id="uploadImage" />
               <Button fullWidth variant="contained" onClick={ClickOpenFile} sx={{fontSize:{xs:"-0.125rem",md:"1.0rem"},padding:{xs:"5px"} }} >تحديث صورة الملف الشخصي</Button>
               <Typography color="darkgray" sx={{fontSize:"12px",marginRight:"20px"}}>مسموح بتنسيق jpg أو png أو GIF</Typography>
           </Grid>
         </Grid>
         <Divider sx={{marginTop:"30px"}}/>
         <Grid container spacing={3}  sx={{marginTop:"10px"}} justifyContent="center" >
                <Grid item xs={10} md={5}>
                     <TextField fullWidth id="outlined-basic" label="الاسم الكامل" variant="outlined" value={name} onChange={(event) => {setName(event.target.value);}} />
                </Grid>
                <Grid item xs={10} md={5}>
                     <TextField fullWidth id="outlined-basic" label="البريد الالكتروني" variant="outlined" type="email" value={email} onChange={(event) =>{ setEmail(event.target.value);}}/>
                </Grid>
               <Grid item xs={10} md={5}>
                   <TextField fullWidth id="outlined-basic" label="رقم الهاتف" variant="outlined" type="number" value={phone} onChange={(event) =>{ setPhone(event.target.value);}}/>
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
         <Card sx={{marginTop:"20px",p:1}}>
              <Grid container spacing={3} 
                  sx={{marginTop:"10px"}} justifyContent="center">
                    <Grid item xs={10} md={3.3}>
                          <TextField fullWidth id="outlined-basic" label="المحافظة" variant="outlined"  onChange={(event) =>{ setId(event.target.value);}}/>
                    </Grid>
                    <Grid item xs={10} md={3.3}>
                        <TextField fullWidth id="outlined-basic" label="المديرية" variant="outlined" value={district} onChange={(event) =>{ setdistrict(event.target.value);}}/>
                    </Grid>
                    <Grid item xs={10} md={3.3}>
                          <TextField fullWidth id="outlined-basic" label="المنطقة" variant="outlined" value={neighborhood} onChange={(event) =>{ setNeighborhood(event.target.value);}} />
                    </Grid>
                    <Grid item xs={10} md={10}>
                          <Button fullWidth variant="contained" onClick={UpdataProfiles}>حفظ التعديلات</Button>
                    </Grid>
              </Grid>
         </Card>
         </Grid>
         <Grid item xs={14} md={10}>
            <Card sx={{marginTop:"20px",p:1}}>
                    <CardHeader title="إلغاء تنشيط عملية التبرع" sx={{'& .css-1kxkc4i-MuiTypography-root':{color:"red"},marginRight:"70px"}}/>
                    <Grid container spacing={2} justifyContent="center" >
                        <Grid item xs={10} md={10} >
                             <Alert icon={false} severity="warning">إن عملية إلغاء الحساب سوف تؤدي الى حذف بياناتك الشخصية مع موقعك ولن تظهر مجددا في موقعنا :)</Alert>  
                          </Grid>
                        <Grid item xs={10} md={10}>
                              <Button fullWidth variant="contained" color="error"  >
                                إلغاء تنشيط عملية التبرع</Button>   
                       </Grid>
                    </Grid>
            </Card>
            </Grid>
            </Grid>
    </Box>
  );
};
export default Profile;

