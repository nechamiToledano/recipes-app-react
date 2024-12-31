import React, { useContext, useState } from "react";
import { TextField, Button, Typography, Box, IconButton, Grow } from "@mui/material";
import { Visibility, VisibilityOff } from "@mui/icons-material";
import { UserContext, StageContext } from "./userReducer";

export const RegistrationForm = ({ email }: { email: string }) => {
    const { user , userDispatch } = useContext(UserContext);
    const { stage, setStage } = useContext(StageContext);
    const isEditMode = stage === 'edit';
    const [formData, setFormData] = useState({
        firstName: user?.firstName || "",
        lastName: user?.lastName || "",
        email: email || "",
        address: user?.address || "",
        password: user?.password || "",
        phone: user?.phone || "",

    });
  const [showPassword, setShowPassword] = useState(false);
  const titles = isEditMode
  ? { header: "Edit Your Account", submit: "Keep Changes" } :
  { header: "Create Your Account", submit: "Register" };


  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    const actionType = isEditMode ? "EDIT" : "REGISTER";
    userDispatch({
        type: actionType,
        data: { ...formData },
    });
    setStage('home')
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
          {["firstName", "lastName", "address", "phone"].map((field) => (
            <TextField
              key={field}
              label={field.replace(/^\w/, (c) => c.toUpperCase())}
              name={field}
              value={formData[field as keyof typeof formData]}
              onChange={handleChange}
              fullWidth
              required
              margin="normal"
              variant="outlined"
            />
          ))}
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
export default RegistrationForm