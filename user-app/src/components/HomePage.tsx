import { Avatar, Box, Divider, IconButton, Menu, MenuItem, Tooltip, Typography } from "@mui/material";
import  { UserContext } from "./userReducer";
import { Logout, Settings } from "@mui/icons-material";
import { useState, useContext } from "react";
const HomePage = ({onLogout,onEdit}:{onLogout:()=>void,onEdit:()=>void    }) => {
    const { user, userDispatch } = useContext(UserContext)
    const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);
 
    const openMenu = Boolean(anchorEl);

    // Profile menu handlers
    const handleMenuClick = (event: React.MouseEvent<HTMLElement>) => {
        setAnchorEl(event.currentTarget);
    };
    const handleMenuClose = () => {
        setAnchorEl(null);
    };

    // Generate user initials for Avatar
    const userInitials = user ? `${user.firstName?.[0] || ""}` : "";

    return (

        <Box height="10vh" alignItems={"center"}>

            <>
                <Tooltip title={"Hello " + user?.firstName} >
                    <IconButton
                        onClick={handleMenuClick}
                        size="small"
                        aria-controls={openMenu ? "profile-menu" : undefined}
                        aria-haspopup="true"
                        aria-expanded={openMenu ? "true" : undefined}
                    >
                        <Avatar
                            src={user?.imagePreview}
                            sx={{ width: 56, height: 56, mt: 2 }}
                        >{userInitials}</Avatar>
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
                        <Avatar
                            src={user?.imagePreview}
                            sx={{ width: 56, height: 56, mt: 2 }}
                        >{userInitials}</Avatar>
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
                        onClick={()=>{userDispatch({ type: "EDIT",data: user});onEdit()}}
                    >
                        <Settings fontSize="small" sx={{ mr: 1 }} />
                        Edit Profile
                    </MenuItem>
                    <MenuItem onClick={()=>{userDispatch({ type: "LOGOUT" });onLogout()}}>
                    <Logout fontSize="small" sx={{ mr: 1 }} />
                    Logout
                </MenuItem>
            </Menu>
        </>
                
        
             
                
            </Box >
       
    );
};
export default HomePage