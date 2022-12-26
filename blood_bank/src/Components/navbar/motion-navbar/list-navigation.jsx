import * as React from "react";
import { motion } from "framer-motion";
import { MenuItem } from "./list-item";
const variants = {
  open: {
    transition: { staggerChildren: 0.07, delayChildren: 0.2 },
  },
  closed: {
    transition: { staggerChildren: 0.09, staggerDirection: -1 },
  },
};
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
export const Navigation = ({ isOpen }) => (
  <motion.ul
    className="motion-ul"
    variants={variants}
    style={{
      display: !isOpen && "none",
    }}
  >
    {navItems.map((item, index) => (
      <MenuItem i={index} key={index} item={item} />
    ))}
  </motion.ul>
);
