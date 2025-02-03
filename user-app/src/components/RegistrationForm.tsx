import React, { useContext, useState } from "react";
import { TextField, Button, Typography, Box, IconButton, Grow, Alert } from "@mui/material";
import { Visibility, VisibilityOff } from "@mui/icons-material";
import axios from "axios";
import { StageContext, UserContext } from "./userReducer";

export const RegistrationForm = () => {
  const url = "http://localhost:3000/";  
  const { stage, setStage } = useContext(StageContext);
  const { user, userDispatch } = useContext(UserContext);

  const titles = stage === 'login' ? { header: 'Login', submit: 'Login' } : { header: 'Create Your Account', submit: 'Register' }
  const [formData, setFormData] = useState({
    email: "",
    password: "",
  });
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState<string | null>(null);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

 
  const handleLogin = async () => {
    try {
      const response = await axios.post(`${url}api/user/login`, {
        email: formData.email,
        password: formData.password,
      });
      const signedUser =await response.data.user;
      
       userDispatch({ type: "LOGIN", data: signedUser });

      setSuccess("Login successful! Welcome back, User ID: " + signedUser.id);
      setStage("home");
    } catch (e: any) {
      setError("Login failed. Please check your credentials and try again.");
    }
  };
  
  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(null);
  
    try {
      const response = await axios.post(`${url}api/user/register`, {
        email: formData.email,
        password: formData.password,
      });
      const updatedUser = response.data;
      userDispatch({ type: "REGISTER", data: updatedUser });
      setSuccess("Registration successful! Your User ID is: " + updatedUser.id);
      setStage("home");
    } catch (e: any) {
      if (e.response?.status === 422) {
        handleLogin();
      } else {
        setError("An error occurred during registration. Please try again.");
      }
    }
  };
  

  return (
    <Grow in>
      <Box
        sx={{
          p: 4,
          bgcolor: "background.paper",
          borderRadius: 2,
          boxShadow: 6,
          maxWidth: 400,
          mx: "auto",
          mt: 10,
          transition: "all 0.3s ease",
          "&:hover": { boxShadow: 10, transform: "translateY(-5px)" },
        }}
      >
        <Typography variant="h5" gutterBottom>
          {titles.header}
        </Typography>

        <form onSubmit={handleSubmit}>
          <TextField
            label="Email"
            name="email"
            type="email"
            value={formData.email}
            onChange={handleChange}
            fullWidth
            required
            margin="normal"
            variant="outlined"
          />
          <TextField
            label="Password"
            name="password"
            type={showPassword ? "text" : "password"}
            value={formData.password}
            onChange={handleChange}
            fullWidth
            required
            margin="normal"
            variant="outlined"
            InputProps={{
              endAdornment: (
                <IconButton onClick={() => setShowPassword(!showPassword)}>
                  {showPassword ? <VisibilityOff /> : <Visibility />}
                </IconButton>
              ),
            }}
          />
          {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}
          {success && <Alert severity="success" sx={{ mb: 2 }}>{success}</Alert>}
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="primary"
            sx={{
              mt: 2,
              py: 1.5,
              fontWeight: "bold",
              textTransform: "none",
              boxShadow: 3,
              "&:hover": { boxShadow: 6, bgcolor: "primary.dark" },
            }}
          >
            {titles.submit}
          </Button>
        </form>
      </Box>
    </Grow>
  );
};

export default RegistrationForm;
