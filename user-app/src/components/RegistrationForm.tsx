import React, { useContext, useState } from "react";
import { Box, Button, Typography, Grow } from "@mui/material";
import { StageContext, UserContext } from "./userReducer";
import axios from "axios";
import FormInput from './FormInput'; 
import Alerts from './Alerts'; 

const RegistrationForm = () => {
  const { stage, setStage } = useContext(StageContext);
  const { user, userDispatch } = useContext(UserContext);
  const [formData, setFormData] = useState({ email: "", password: "" });
  const [showPassword, setShowPassword] = useState(false);
  const [message, setMessage] = useState<{ type: "error" | "success"; text: string } | null>(null);

  const titles = stage === "login" ? { header: "Login", submit: "Login" } : { header: "Create Your Account", submit: "Register" };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => setFormData({ ...formData, [e.target.name]: e.target.value });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMessage(null);

    try {
      const response = stage === "login" 
        ? await axios.post("http://localhost:3000/api/user/login", formData) 
        : await axios.post("http://localhost:3000/api/user/register", formData);
        
      const signedUser = response.data.user;
      
      userDispatch({ type: stage === "login" ? "LOGIN" : "REGISTER", data: signedUser });
      console.log(user);

      setMessage({ type: "success", text: `${stage === "login" ? "Login" : "Registration"} successful!` });
      setStage("home");
    } catch (error) {
      setMessage({ type: "error", text: error?.response?.data?.message || "An error occurred." });
    }
  };

  return (
    <Grow in>
      <Box sx={{ p: 4, bgcolor: "background.paper", borderRadius: 2, boxShadow: 6, maxWidth: 400, mx: "auto", mt: 10 }}>
        <Typography variant="h5" gutterBottom>{titles.header}</Typography>
        <form onSubmit={handleSubmit}>
          <FormInput label="Email" name="email" type="email" value={formData.email} onChange={handleChange} />
          <FormInput
            label="Password"
            name="password"
            type={showPassword ? "text" : "password"}
            value={formData.password}
            onChange={handleChange}
            showPassword={showPassword}
            togglePasswordVisibility={() => setShowPassword(!showPassword)}
          />
          <Alerts error={message?.type === "error" ? message.text : null} success={message?.type === "success" ? message.text : null} />
          <Button
            type="submit"
            fullWidth
            variant="contained"
            color="success"
            sx={{ mt: 2, py: 1.5, fontWeight: "bold", textTransform: "none", boxShadow: 3 }}
          >
            {titles.submit}
          </Button>
        </form>
      </Box>
    </Grow>
  );
};

export default RegistrationForm;
