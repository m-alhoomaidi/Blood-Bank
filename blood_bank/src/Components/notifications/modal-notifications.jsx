import {
  Modal,
  Fade,
  Box,
  CardHeader,
  Card,
  CardContent,
  Divider,
  Grid,
  TextField,
  Typography,
  Button,
  Backdrop,
  IconButton,
} from "@mui/material";
import { ModalContainerStyle } from "../../style/global-style";
import CloseIcon from "@mui/icons-material/Close";
import { FlexVertical } from "../common/flex-vertical";
import { db,auth } from "../../utils/firebase";
import { doc, updateDoc } from "firebase/firestore";

export const ModalViewNotification = (props) => {
  const { open, handleClose, notification,Id,BackNotification } = props;
  const IsReading =  async () =>{
    handleClose();
    const read = true;
         const userDoc = doc (db,"notifications",Id);
     updateDoc(userDoc ,{ isRead : true}).then((response) =>{
      console.log("succses")
      BackNotification(true);
     });
   };
  return (
    <>
      <Modal
        aria-labelledby="transition-modal-title"
        aria-describedby="transition-modal-description"
        open={open}
        onClose={handleClose}
        closeAfterTransition
        BackdropComponent={Backdrop}
        BackdropProps={{
          timeout: 500,
        }}
      >
        <Fade in={open}>
          <form>
            <Box
              sx={{
                ...ModalContainerStyle,
                width: {
                  xs: "80%",
                  md: "50%",
                },
                borderRadius: 1,
              }}
            >
              {
                <>
                  <FlexVertical>
                    <Box
                      sx={{
                        display: "flex",
                        justifyContent: "space-between",
                        alignItems: "center",
                      }}
                    >
                      <Typography variant="h5">
                        {notification?.title}
                      </Typography>
                      <IconButton onClick={IsReading}>
                        <CloseIcon />
                      </IconButton>
                    </Box>
                    <Divider />
                    <Box>
                      <Typography>{notification?.body}</Typography>
                    </Box>
                    <Box>
                      <Typography
                        sx={{
                          display: "inline",
                          color: "gray",
                        }}
                        component="span"
                        variant="body2"
                      >
                        {`${notification?.createdAt}`}
                      </Typography>
                    </Box>
                  </FlexVertical>
                </>
              }
            </Box>
          </form>
        </Fade>
      </Modal>
    </>
  );
};
