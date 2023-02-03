import { async } from "@firebase/util";
import {
  Box,
  Divider,
  List,
  ListItem,
  ListItemText,
  MenuList,
  Popover,
  Typography,
} from "@mui/material";
import { getToken } from "firebase/messaging";
import { useState ,useEffect} from "react";
import { messaging } from "../../../utils/firebase";
import { ModalViewNotification } from "../../notifications/modal-notifications";


const Notifications = [
  {
    title: "أهلا بعودتك مجددا",
    body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوي",
    createdAt: "2021-12-31",
  },
  {
    title: "أهلا بعودتك مجددا",
    body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوي",
    createdAt: "2021-12-31",
  },
  {
    title: "أهلا بعودتك مجددا",
    body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوي",
    createdAt: "2021-12-31",
  },
  {
    title: "أهلا بعودتك مجددا",
    body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوي",
    createdAt: "2021-12-31",
  },
  {
    title: "أهلا بعودتك مجددا",
    body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوي",
    createdAt: "2021-12-31",
  },
  {
    title: "أهلا بعودتك مجددا",
    body: "هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوي",
    createdAt: "2021-12-31",
  },
];


export const NotificationPopover = (props) => {
  const { anchorEl, onClose, open, setOpenNotificationPopover, ...other } =
    props;
  const [isOpen, setIsOpen] = useState(false);
  const [notificationData, setNotificationData] = useState({});

  const handleClose = () => setIsOpen(false);
  async function requestPermissions (){
  await Notification.requestPermission().then((permission)=>{
    if(permission === 'granted'){
      getToken(messaging,{vapidKey:'BBn3zGcKMynrgirvOIsFXTHoTHKNW-iX3FWefaw9zUVbRygfIzYSQqHqJabWsNcg5v-oYG2E1tDBsh42WR7RNzQ'}).then((token)=>{
     //  console.log(token);
      });
    } else if(permission === 'denied') 
    {
     alert("rrrrrrrrrrrrr")
 
    }
   

   });
  }
  useEffect(()=>{
    requestPermissions();

  },[]);

  return (
    <>
      {isOpen && notificationData && (
        <ModalViewNotification
          notification={notificationData}
          open={isOpen}
          handleClose={handleClose}
        />
      )}
      <Popover
        anchorEl={anchorEl}
        anchorOrigin={{
          vertical: "bottom",
          horizontal: "left",
        }}
        onClose={onClose}
        open={open}
        PaperProps={{
          sx: { width: "400px", height: "90%" },
        }}
        {...other}
        sx={{
          borderRadius: 0,
        }}
      >
        <Box
          sx={{
            py: 1.5,
            px: 2,
          }}
        >
          <Typography variant="overline">الإشعارات</Typography>
        </Box>
        <MenuList
          disablePadding
          sx={{
            "& > *": {
              "&:first-of-type": {
                borderTopColor: "divider",
                borderTopStyle: "solid",
                borderTopWidth: "1px",
              },
              padding: "12px 16px",
            },
          }}
        >
          {Notifications.map((notification, index) => (
            <List
              key={index}
              sx={{
                backgroundColor: index % 2 ? "white" : "#e9ecef",
                mt: -1,
              }}
            >
              <ListItem>
                <ListItemText
                  onClick={() => {
                    setNotificationData(notification);
                    setOpenNotificationPopover(false);
                    setIsOpen(true);
                  }}
                  sx={{
                    textAlign: "right",
                    cursor: "pointer",
                  }}
                  primary={notification?.title}
                  primaryTypographyProps={{
                    fontWeight: "bold",
                  }}
                  secondary={<>{notification?.body?.slice(0, 100)}</>}
                  secondaryTypographyProps={{
                    fontSize: 13,
                    color: "gray",
                  }}
                />
              </ListItem>
              <Typography
                sx={{
                  display: "inline",
                  color: "gray",
                  mr: 2,
                  textAlign: "right",
                }}
                component="span"
                variant="body2"
              >
                {notification?.createdAt}
              </Typography>
              <Divider />
            </List>
          ))}
        </MenuList>
      </Popover>
    </>
  );
};
