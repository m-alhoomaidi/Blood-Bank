import * as React from "react";
import {
  AppBar,
  Box,
  IconButton,
  List,
  ListItem,
  ListItemButton,
  ListItemText,
  Toolbar,
  Link,
  Divider,
  CardMedia,
  Typography,
} from "@mui/material";
import { Container } from "@mui/system";
import { Fade as Hamburger } from "hamburger-react";
import { useState } from "react";

const navItems = [
  {
    id: 1,
    name: "الرئيسية",
    href: "#",
  },
  {
    id: 2,
    name: "انشاء حساب",
    href: "#",
  },
  {
    id: 3,
    name: "تسجيل الدخول",
    href: "#",
  },
  {
    id: 2,
    name: "خدماتنا",
    href: "#services",
  },
  {
    id: 3,
    name: "تبرع",
    href: "#about",
  },
];

const fontColor = "#343a40";
const AppBarBackground = "#f8f9fa";
const RedColorValue = "#e63946";
const NavBar = (props) => {
  const [mobileOpen, setMobileOpen] = useState(false);
  const handleDrawerToggle = () => {
    setMobileOpen(!mobileOpen);
  };

  const navItemsListMoblie = navItems.map((item, index) => (
    <Link
      key={item.name}
      href={item.href}
      sx={{
        textDecoration: "none",
        color: fontColor,
      }}
    >
      <Container fixed>
        <ListItem onClick={handleDrawerToggle}>
          <ListItemButton
            sx={{
              transition: "0.5s",
              "&:hover": {
                color: "white",
                backgroundColor: RedColorValue,
              },
            }}
          >
            <ListItemText>
              <Typography align="center">{item.name}</Typography>
            </ListItemText>
          </ListItemButton>
        </ListItem>
        {navItems.length - 1 != index && <Divider />}
      </Container>
    </Link>
  ));

  const navItemsList = navItems.map((item) => (
    <Link
      href={item.href}
      key={item.name}
      sx={{
        color: fontColor,
        textDecoration: "none",
        transition: "0.5s",
        p: 2,
        "&:hover": {
          color: "white",
          backgroundColor: RedColorValue,
        },
      }}
    >
      <Typography sx={{ display: "inline" }}> {item.name}</Typography>
    </Link>
  ));

  const drawer = (
    <Box sx={{ backgroundColor: "white" }}>
      <List>{navItemsListMoblie}</List>
    </Box>
  );

  return (
    <>
      <AppBar
        sx={{
          backgroundColor: AppBarBackground,
          position: { xs: "static", md: "fixed" },
        }}
      >
        <Toolbar
          sx={{
            display: "flex",
            justifyContent: "space-between",
          }}
        >
          <Box sx={{ display: { xs: "block", md: "none" } }}>
            <IconButton
              sx={{
                color: "white",
                alignSelf: "flex-end",
              }}
            >
              <Hamburger
                direction="left"
                size={22}
                toggled={mobileOpen}
                toggle={setMobileOpen}
                color="black"
              />
            </IconButton>
          </Box>
          <Box
            sx={{
              display: { xs: "none", md: "flex" },
            }}
          >
            <Box>{navItemsList}</Box>
          </Box>
          <Box
            sx={{
              width: "40px",
              height: "40px",
              cursor: "pointer",
            }}
          >
            <CardMedia component="img" image="/logo.png" />
          </Box>
        </Toolbar>
      </AppBar>
      {mobileOpen && (
        <Box component="nav" sx={{ display: { xs: "block", md: "none" } }}>
          {drawer}
        </Box>
      )}
    </>
  );
};
export default NavBar;
