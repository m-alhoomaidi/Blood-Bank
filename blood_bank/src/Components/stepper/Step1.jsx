import { TextField } from "@material-ui/core";
import { makeStyles } from "@material-ui/core/styles";
const useStyles = makeStyles((theme) => ({
  button: {
    marginRight: theme.spacing(5),
  },
  textField: {
    [`& fieldset`]: {
      borderRadius: "7px",
      color: "black",
    },
    marginBottom: theme.spacing(1),
    borderRadius: "7px",
    color: "black",
    fontWeight: "bold",
    "& .MuiSvgIcon-root": {
      fill: "black",
    },
  },
  labels: {
    color: "black",
    fontWeight: "bold",
    fontSize: "1.2em",
    marginLeft: "20px",
  },
}));
const Steps1 = () => {
  const classes = useStyles();
  return (
    <>
          <TextField
            name="fullName"
            id="full-name"
            margin="normal"
            required
            fullWidth
            autoComplete="fullname"
            autoFocus
            label=" الاسم الرباعي"
            variant="outlined"
          />
          <TextField
            name="userEmail"
            id="userEmail"
            margin="normal"
            required
            fullWidth
            autoComplete="email"
            label="البريد الالكتروني"
            variant="outlined"
            type="email"
          />
        
          <TextField
            name="phoneNumber"
            id="Phone-Number"
            margin="normal"
            required="phone"
            fullWidth
            label="رقم الهاتف "
            variant="outlined"
          />
        
          <TextField
            name="password"
            id="password"
            margin="normal"
            required
            fullWidth
            label=" كلمة السر"
            type="password"
            variant="outlined"
          />
    </>
  );
};
export default Steps1;
