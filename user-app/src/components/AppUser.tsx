import { useState } from "react";
import { Box, Menu, MenuItem, Avatar, IconButton, CssBaseline, Container, Button, colors, ListItemIcon } from "@mui/material";
import RegistrationForm from "./RegistrationForm";
import EditForm from "./EditForm";
import { StageContext, StageType } from "./userReducer";
import Profile from "./Profile";
import { AppRegistration, Login } from "@mui/icons-material";

const AppUser = () => {

    const [stage, setStage] = useState<StageType>("navigation");

    const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
    const handleMenuOpen = (event: React.MouseEvent<HTMLElement>) => setAnchorEl(event.currentTarget);
    const handleMenuClose = () => setAnchorEl(null);


    return (
        <StageContext.Provider value={{ stage, setStage }}>
            <CssBaseline />

            <Container>
                {stage === "navigation" && (
                    <Box sx={{ display: "flex", alignItems: "center", justifyContent: "center", height: "10vh" }}>

                        <IconButton
                            onClick={handleMenuOpen}
                            size="large"
                            edge="start"
                            color="success"
                            aria-label="menu"
                            sx={{ mr: 2 }}
                        >
                            <Avatar sx={{
                                bgcolor: 'lightblue'
                            }}></Avatar>

                        </IconButton>
                        <Menu anchorEl={anchorEl} open={Boolean(anchorEl)} onClose={handleMenuClose} sx={{ mt: 1 }}>

                            <MenuItem onClick={() => { setStage("login"); handleMenuClose(); }}><ListItemIcon>
                                <Login fontSize="small" />
                            </ListItemIcon>
                                Login</MenuItem>
                                
                            <MenuItem onClick={() => { setStage("register"); handleMenuClose(); }}><ListItemIcon><AppRegistration/></ListItemIcon>Register</MenuItem>


                        </Menu>
                    </Box>
                )}

                {stage === "home" && <Profile />}
                {stage === "login" && <RegistrationForm />}
                {stage === "register" && <RegistrationForm />}
                {stage === "edit" && <EditForm />}
            </Container>
        </StageContext.Provider>
    );
};

export default AppUser;
