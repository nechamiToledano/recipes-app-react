import { Avatar, Box, Button, Divider, IconButton, Menu, MenuItem, Tooltip, Typography } from "@mui/material";
import userReducer, { UserContext, UserType } from "./userReducer";
import ModalForm from "./ModalForm";
import { Login, Logout, Settings } from "@mui/icons-material";
import { useState, useReducer } from "react";
import LoginIcon from '@mui/icons-material/Login';
const HomePage = () => {
    const initialState: UserType = null;
    const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
    const [user, userDispatch] = useReducer(userReducer, initialState);
    const [showModal, setShowModal] = useState(false);
    const [isEditMode, setIsEditMode] = useState(false);

    const openMenu = Boolean(anchorEl);

    // Profile menu handlers
    const handleMenuClick = (event: React.MouseEvent<HTMLElement>) => {
        setAnchorEl(event.currentTarget);
    };
    const handleMenuClose = () => {
        setAnchorEl(null);
    };
    const handleLogout = () => {
        userDispatch({ type: "REMOVE_USER" });
        handleMenuClose();
    };

    // Handle login
    const handleLogin = (userData: UserType) => {
        userDispatch({ type: "CREATE_USER", data: userData });
        setShowModal(false);
    };

    // Handle edit (update only non-null fields)
    const handleSubmit = (updatedData: Partial<UserType>) => {
        userDispatch({ type: "EDIT_USER", data: updatedData });
        setShowModal(false);
        handleMenuClose();
    };

    // Generate user initials for Avatar
    const userInitials = user ? `${user.firstName?.[0] || ""}` : "";

    return (
        <UserContext.Provider value={{ user, userDispatch }}>
            <Box height="100vh" alignItems={"center"}>
                {!user ? (
                    <>
                        
                            <Button variant="contained"  onClick={() => {
                                setIsEditMode(false);
                                setShowModal(true);
                            }} endIcon={<LoginIcon />}>
                                Login
                            </Button>

                       
                    </>
                ) : (
                    <>
                        <Tooltip title={"Hello " + user.firstName} >
                            <IconButton
                                onClick={handleMenuClick}
                                size="small"
                                aria-controls={openMenu ? "profile-menu" : undefined}
                                aria-haspopup="true"
                                aria-expanded={openMenu ? "true" : undefined}
                            >
                                <Avatar>{userInitials}</Avatar>
                            </IconButton>
                        </Tooltip>
                        <Menu
                            anchorEl={anchorEl}
                            id="profile-menu"
                            open={openMenu}
                            onClose={handleMenuClose}
                            transformOrigin={{ horizontal: "right", vertical: "top" }}
                            anchorOrigin={{ horizontal: "right", vertical: "bottom" }}
                        >
                            <Box p={2} display="flex" flexDirection="column" alignItems="center" >
                                <Avatar sx={{ width: 64, height: 64, mb: 1 }}>{userInitials}</Avatar>
                                <Typography variant="h6">{user?.firstName + ' ' + user?.lastName || "Guest"}</Typography>
                                <Typography variant="body2" color="text.secondary">
                                    {user?.address || ""}
                                </Typography>
                                <Typography variant="body2" color="text.secondary">
                                    {user?.phone || ""}
                                </Typography>

                                <Typography variant="body2" color="text.secondary">
                                    {user?.email || ""}
                                </Typography>
                            </Box>
                            <Divider />
                            <MenuItem
                                onClick={() => {
                                    setIsEditMode(true);
                                    setShowModal(true);
                                }}
                            >
                                <Settings fontSize="small" sx={{ mr: 1 }} />
                                Edit Profile
                            </MenuItem>
                            <MenuItem onClick={handleLogout}>
                                <Logout fontSize="small" sx={{ mr: 1 }} />
                                Logout
                            </MenuItem>
                        </Menu>
                    </>
                )}
                {showModal && (
                    <ModalForm
                        open={showModal}
                        onClose={() => setShowModal(false)}
                        onLogin={handleLogin}
                        onSubmit={handleSubmit}
                        isEditMode={isEditMode}
                        existingData={user}
                    />
                )}
            </Box>
        </UserContext.Provider>
    );
};
export default HomePage