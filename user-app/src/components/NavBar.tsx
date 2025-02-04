import { AppBar, Toolbar, Box, Button, Typography } from "@mui/material";
import { NavLink } from "react-router-dom";
import AppUser from "./AppUser";

const NavBar = () => {
  return (
    <AppBar  sx={{ backgroundColor:'mintcream' }}>
      <Toolbar sx={{ display: "flex", justifyContent: "space-between" }}>
        {/* Left: AppUser Menu */}
        <Box position={"fixed"} left={5} top={2}>
          <AppUser />
        </Box>

        {/* Right: Navigation Links */}
        <Box position={"fixed"} right={5} top={10}>
          <Button
            component={NavLink as any}
            to="/"
            color="success"
            sx={{ textTransform: "none", mx: 1 }}
          >
            Home
          </Button>
          <Button
            component={NavLink as any}
            to="/about"
            color="success"
            sx={{ textTransform: "none", mx: 1 }}
          >
            About
          </Button>
          <Button
            component={NavLink as any}
            to="/recipes"
            color="success"
            sx={{ textTransform: "none", mx: 1 }}
          >
            Recipes
          </Button>
        </Box>
      </Toolbar>
    </AppBar>
  );
};

export default NavBar;
