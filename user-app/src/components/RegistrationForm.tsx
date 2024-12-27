import React, { useContext, useRef, useState } from "react";
import { Box, Typography, TextField, Button, styled } from "@mui/material";
import { Visibility, VisibilityOff } from "@mui/icons-material";
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
import { UserContext } from "./userReducer";

const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
});

const RegistrationForm = ({
    onSubmit,
   
}: {
    onSubmit: () => void;
}) => {
    const { user, userDispatch } = useContext(UserContext);
    const [showPassword, setShowPassword] = useState(false);
    const firstNameRef = useRef<HTMLInputElement>(null);
    const lastNameRef = useRef<HTMLInputElement>(null);
    const emailRef = useRef<HTMLInputElement>(null);
    const addressRef = useRef<HTMLInputElement>(null);
    const passwordRef = useRef<HTMLInputElement>(null);
    const phoneRef = useRef<HTMLInputElement>(null);
    const imageRef = useRef<File | null>(null);

    const handleImageUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
        if (event.target.files && event.target.files.length > 0) {
            imageRef.current = event.target.files[0]; // Store the uploaded file
        }
    };

    const handleClickShowPassword = () => setShowPassword((show) => !show);
   
    const handleMouseDownPassword = (event: React.MouseEvent<HTMLButtonElement>) => {
        event.preventDefault();
    };
   
    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();

        // Extract values from refs
        const firstName = firstNameRef.current?.value || '';
        const lastName = lastNameRef.current?.value || '';
        const email = emailRef.current?.value || '';
        const address = addressRef.current?.value || '';
        const password = passwordRef.current?.value || '';
        const phone = phoneRef.current?.value || '';
        const imagePreview = imageRef.current?.name ||'' // Assuming you want to store the file name

        // Dispatch the user registration action
        userDispatch({ 
            type: "REGISTER", 
            data: { firstName, lastName, email, address, password, phone, imagePreview} 
        });
        
        // Call the onSubmit callback
        onSubmit();
    };

    return (
        <Box>
            <Typography variant="h5" gutterBottom>
                 Your Account
            </Typography>
            <form onSubmit={handleSubmit}>
                <TextField
                    variant="filled"
                    label="First Name"
                    fullWidth
                    required
                    margin="normal"
                    value={user?.firstName}
                    inputRef={firstNameRef}
                />
                <TextField
                    variant="filled"
                    label="Last Name"
                    fullWidth
                    required
                    value={user?.lastName}
                    margin="normal"
                    inputRef={lastNameRef}
                />
                <TextField
                    variant="filled"
                    label="Email"
                    type="email"
                    fullWidth
                    required
                    defaultValue={user?.email}
                    margin="normal"
                    disabled
                    inputRef={emailRef}
                    
                />
                <TextField
                    variant="filled"
                    label="Address"
                    fullWidth
                    required
                    margin="normal"
                    inputRef={addressRef}
                    value={user?.address}
                />
                <TextField
                    variant="filled"
                    label="Password"
                    type={showPassword ? "text" : "password"}
                    fullWidth
                    required
                    margin="normal"
                    inputRef={passwordRef}
                    value={user?.password}
                    InputProps={{
                        endAdornment: (
                            <Button
                                onClick={handleClickShowPassword}
                                onMouseDown={handleMouseDownPassword}
                            >
                                {showPassword ? <VisibilityOff /> : <Visibility />}
                            </Button>
                        ),
                    }}
                />
                <TextField
                    variant="filled"
                    label="Phone"
                    fullWidth
                    required
                    margin="normal"
                    inputRef={phoneRef}
                    value={user?.phone}
                />
                <Button
                    component="label"
                    startIcon={<CloudUploadIcon />}
                >
                    Upload Image
                    <VisuallyHiddenInput
                        type="file"
                        accept="image/*" 
                        onChange={handleImageUpload}
                        
                    />
                </Button>
                <Button type="submit" fullWidth>
                    Register
                </Button>
            </form>
        </Box>
    );
};

export default RegistrationForm;
