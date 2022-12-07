import * as React from "react";
import { useRef } from "react";
import { motion, useCycle } from "framer-motion";
import { MenuToggle } from "./list-toggle";
import { Navigation } from "./list-navigation";
import "./styles.css";
import { Box } from "@mui/system";
import LottieApp from "../../lottie";
import {
  LOGO_LOTTIE,
} from "../../../constant/media";
const sidebar = {
  open: (height = 1000) => ({
    clipPath: `circle(${height * 2 + 200}px at 40px 40px)`,
    transition: {
      type: "spring",
      stiffness: 20,
      restDelta: 2,
    },
  }),
  closed: {
    clipPath: "circle(30px at 40px 40px)",
    transition: {
      delay: 0.5,
      type: "spring",
      stiffness: 400,
      damping: 40,
    },
  },
};

export const EmotionList = () => {
  const [isOpen, toggleOpen] = useCycle(false, true);
  const containerRef = useRef(null);
  return (
    <motion.nav
      initial={false}
      animate={isOpen ? "open" : "closed"}
      custom={600}
      ref={containerRef}
    >
      <motion.div className="background" variants={sidebar} />
      <Navigation />
      <MenuToggle toggle={() => toggleOpen()} />
      <Box
        sx={{
          cursor: "pointer",
          position: "absolute",
          top: "18px",
          right: "1px",
          width: "100px",
          height: "100px",
        }}
      >
        <LottieApp animationpath={LOGO_LOTTIE} />
      </Box>
    </motion.nav>
  );
};
