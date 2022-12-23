import * as React from "react";
import Avatar from "@mui/material/Avatar";
import Button from "@mui/material/Button";
import TextField from "@mui/material/TextField";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Link from "@mui/material/Link";
import Paper from "@mui/material/Paper";
import Box from "@mui/material/Box";
import Grid from "@mui/material/Grid";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import Typography from "@mui/material/Typography";
import LottieApp from "../Components/lottie";
import { HEALTH_LOTTIE, HEART_PULSE_LOTTIE } from "../constant/media";
export default function SignInSide() {
  return (
       <Grid container component="main" sx={{ height: "100vh", dir: "ltr" }}>
      <Grid item xs={12} md={6}>
        <Box
          sx={{
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            height: "100%",
          }}
        >
          <LottieApp animationpath={HEALTH_LOTTIE} />
        </Box>
      </Grid>
      <Grid item xs={12} md={6}>
        <Box
          sx={{
            display: "flex",
            width: "100%",
            height: "92%",
            justifyContent: "center",
            alignItems: "center",
            pb: 8,
          }}
        >
          <Box
            sx={{
              display: "flex",
              justifyContent: "center",
              justifyItems: "center",
              flexDirection: "column",
              width: { xs: "90%", md: "70%" },
            }}
          >
            <Box
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
                flexDirection: "column",
              }}
            >
              <Avatar sx={{ m: 1, bgcolor: "#e12c34" }}>
                <LockOutlinedIcon />
              </Avatar>
              <Typography>تسجيل الدخول</Typography>
            </Box>
            <TextField
              margin="normal"
              required
              fullWidth
              id="email"
              label="عنوان البريد الإلكتروني"
              name="email"
              autoComplete="email"
              autoFocus
              dir="ltr"
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
              dir="ltr"
            />
            <FormControlLabel
              control={<Checkbox value="remember" color="primary" />}
              label="تذكرني"
              sx={{
                color: "gray",
              }}
            />
            <Button
              type="submit"
              fullWidth
              variant="contained"
              sx={{
                mt: 3,
                mb: 2,
                bgcolor: "#e12c34",
                "&:hover": {
                  backgroundColor: "red",
                  textDecoration: "none",
                },
              }}
            >
              تسجيل الدخول
            </Button>
            <Box
              sx={{
                display: "flex",
                mt: 3,
                justifyContent: "space-between",
              }}
            >
              <Link
                href="#"
                variant="body2"
                sx={{
                  color: "blue",
                }}
              >
                هل نسيت كلمة السر ؟
              </Link>
              <Link href="#" variant="body2">
                {" لا تمتلك حساب ؟ انشىء حساب ."}
              </Link>
            </Box>
          </Box>
        </Box>
      </Grid>
    </Grid>
  );
}
