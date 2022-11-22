import * as React from 'react';
import Divider from '@mui/material/Divider';
import Typography from '@mui/material/Typography';
import ListItemButton from '@mui/material/ListItemButton';
import TextField from '@mui/material/TextField';
const  EditAccount = () => {
    return (
        <div style={{marginTop:"30px",marginRight:"20px",background:"white"}}>
      <Typography variant="h5" gutterBottom >
        الحساب
      </Typography>
     <ListItemButton>
     <TextField
  variant="standard"
  InputProps={{
         disableUnderline: true,
       }}
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
        }
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+967 775076363"
  helperText="أنقر لتعيير رقم الهاتف"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
     </ListItemButton>
     <Divider/>
     <ListItemButton>
     <TextField
  variant="standard"
  InputProps={{
         disableUnderline: true,
       }}
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
        }
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="+A"
  helperText="أنقر لتعيير فصيلة الدم"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
     </ListItemButton>
     <Divider/>
     <ListItemButton>
     <TextField
  variant="standard"
  InputProps={{
         disableUnderline: true,
       }}
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
        }
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="abdullah@gmail.com"
  helperText="أنقر لتعيير  البريد الالكتروني"
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
     </ListItemButton>
     <Divider />
     <ListItemButton>
     <TextField
  variant="standard"
  InputProps={{
         disableUnderline: true,
       }}
       sx={{
        '& .css-1d1r5q-MuiFormHelperText-root' :{
          textAlign: 'right',
        }
       }}
  required
  multiline
  id="phoneNumber"
  defaultValue="إب - جبلة - الشراعي"
  helperText="أنقر لتغيير  المحافظة -المديرية -المنطقة "
  name="phoneNumber"
  autoComplete="phoneNumber"
/>
     </ListItemButton>
     <Divider />

    </div>

    );
};
export default EditAccount;