import { useReducer, useState } from "react";
import { Box, Menu, MenuItem, Avatar, IconButton, CssBaseline, Container, Button } from "@mui/material";
import RegistrationForm from "./RegistrationForm";
import EditForm from "./EditForm";
import userReducer, { UserContext, UserType, StageContext, StageType } from "./userReducer";
import Profile from "./Profile";
import MenuIcon from '@mui/icons-material/Menu';
import NavBar from "./NavBar";
const AppUser = () => {
    const initialState: UserType = null;
    const [user, userDispatch] = useReducer(userReducer, initialState);
    const [stage, setStage] = useState<StageType>("navigation");

    const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
    const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => setAnchorEl(event.currentTarget);
    const handleMenuClose = () => setAnchorEl(null);


    return (
        <UserContext.Provider value={{ user, userDispatch }}>
            <StageContext.Provider value={{ stage, setStage }}>
                <CssBaseline />

                <Container>
                    {stage === "navigation" && (
                        <Box sx={{ display: "flex", alignItems: "center", justifyContent: "center", height: "10vh" }}>

                            <IconButton
                                onClick={handleMenuOpen}
                                size="large"
                                edge="start"
                                color="inherit"
                                aria-label="menu"
                                sx={{ mr: 2 }}
                            >
                                <MenuIcon fontSize="large" />
                            </IconButton>
                            <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleMenuClose} sx={{ mt: 1 }}>

                                <MenuItem onClick={() => { setStage("login"); handleMenuClose(); }}>Login</MenuItem>
                                <MenuItem onClick={() => { setStage("register"); handleMenuClose(); }}>Register</MenuItem>


                            </Menu>
                        </Box>
                    )}

                    {stage === "home" && <Profile />}
                    {stage === "login" && <RegistrationForm />}
                    {stage === "register" && <RegistrationForm />}
                    {stage === "edit" && <EditForm />}
                </Container>
            </StageContext.Provider>
        </UserContext.Provider>
    );
};

export default AppUser;
