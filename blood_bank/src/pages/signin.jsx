import * as React from 'react';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import CssBaseline from '@mui/material/CssBaseline';
import TextField from '@mui/material/TextField';
import FormControlLabel from '@mui/material/FormControlLabel';
import Checkbox from '@mui/material/Checkbox';
import Link from '@mui/material/Link';
import Paper from '@mui/material/Paper';
import Box from '@mui/material/Box';
import Grid from '@mui/material/Grid';
import LockOutlinedIcon from '@mui/icons-material/LockOutlined';
import Typography from '@mui/material/Typography';
import { createTheme, ThemeProvider } from '@mui/material/styles';
import Img from '../../Images/fh-pr-image-blood.jpg'

function Copyright(props) {
  return (
    <Typography variant="body2" color="text.secondary" align="center" {...props}>
      {'Copyright © '}
      <Link color="inherit" href="https://mui.com/">
        Elctronic Blood Bank
      </Link>{' '}
      {new Date().getFullYear()}
      {'.'}
    </Typography>
  );
}

const theme = createTheme();

export default function SignInSide() {
  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData(event.currentTarget);
    console.log({
      email: data.get('email'),
      password: data.get('password'),
    });
  };

  return (
    <ThemeProvider theme={theme}>
      <Grid container component="main" sx={{ height: '100vh',dir:"ltr" }}>
        <CssBaseline />
        <Grid
          item
          xs={false}
          sm={4}
          md={7}
          sx={{
            backgroundImage: `url(${Img})`,
            backgroundRepeat: 'no-repeat',
            backgroundColor: (t) =>
              t.palette.mode === 'light' ? t.palette.grey[50] : t.palette.grey[900],
            backgroundSize: 'cover',
            backgroundPosition: 'center',
          }}
        />
        <Grid item xs={12} sm={8} md={5} component={Paper} elevation={6} square>
          <Box
            sx={{
              my: 8,
              mx: 4,
              display: 'flex',
              flexDirection: 'column',
              alignItems: 'center',
            }}
          >
            <Avatar sx={{ m: 1, bgcolor: '#e12c34' }}>
              <LockOutlinedIcon/>
            </Avatar>
            <Typography component="h1" variant="h5">
              تسجيل الدخول
            </Typography>
            <Box component="form" Validate onSubmit={handleSubmit} sx={{ mt: 1}}>
              <TextField
                margin="normal"
                required
                fullWidth
                id="email"
                label="عنوان البريد الإلكتروني"
                name="email"
                autoComplete="email"
                autoFocus
                dir='ltr'
                align="right"
              />
              <TextField
                margin="normal"
                required
                fullWidth
                name="password"
                label="كلمة السر"
                type="password"
                id="password"
                autoComplete="current-password"
                dir='ltr'
                
              />
              <FormControlLabel
                control={<Checkbox value="remember" color="primary" />}
                label="تذكرني"
              />
              <Button
                type="submit"
                fullWidth
                variant="contained"
                sx={{ 
                  mt: 3,
                  mb: 2,
                  bgcolor: '#e12c34',
                  "&:hover": {
                    backgroundColor: "red",
                  }, }}
              >
                تسجيل الدخول
              </Button>
              <Grid container>
                <Grid item xs>
                  <Link href="#" variant="body2">
                    هل نسيت كلمة السر ؟
                  </Link>
                </Grid>
                <Grid item>
                  <Link href="#" variant="body2">
                    {" لا تمتلك حساب ؟ انشىء حساب ."}
                  </Link>
                </Grid>
              </Grid>
              <Copyright sx={{ mt: 5 }} />
            </Box>
          </Box>
        </Grid>
      </Grid>
    </ThemeProvider>
  );
}