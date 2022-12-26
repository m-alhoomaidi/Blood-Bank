import {
  Box,
  CardMedia,
  Grid,
  IconButton,
  Link,
  Typography,
} from "@mui/material";
import { SECONDARY_COLOR } from "../../constant/color";
import FacebookIcon from "@mui/icons-material/Facebook";
import InstagramIcon from "@mui/icons-material/Instagram";
import WhatsAppIcon from "@mui/icons-material/WhatsApp";
import TwitterIcon from "@mui/icons-material/Twitter";
import TelegramIcon from "@mui/icons-material/Telegram";
export const Footer = () => {
  return (
    <>
      <Box
        sx={{
          backgroundColor: "#22333b",
          height: "170px",
          display: "flex",
          justifyContent: "space-around",
          alignItems: "center",
          flexDirection: "column",
        }}
      >
        <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
          <CardMedia
            component="img"
            src="logo.png"
            sx={{
              height: "40px",
              width: "40px",
            }}
          />
        </Box>
        <Box sx={{ display: "flex", alignItems: "center", gap: 2 }}>
          <IconButton>
            <FacebookIcon sx={{ color: "white" }} />
          </IconButton>
          <IconButton>
            <InstagramIcon sx={{ color: "white" }} />
          </IconButton>
          <IconButton>
            <TwitterIcon sx={{ color: "white" }} />
          </IconButton>
          <IconButton>
            <WhatsAppIcon sx={{ color: "white" }} />
          </IconButton>
          <IconButton>
            <TelegramIcon sx={{ color: "white" }} />
          </IconButton>
        </Box>
        <Box>
          <Link sx={{ textDecoration: "none" }}>
            <Typography>سياسية الحماية والخصوصية</Typography>
          </Link>
        </Box>
        <Box>
          <Typography sx={{ color: "gray" }}>
            {`جميع الحقوق محفوظة@ ${new Date()?.toISOString()?.slice(0, 10)}`}
          </Typography>
        </Box>
      </Box>
    </>
  );
};
