import React, { useState, useContext } from "react";
import { TextField, Button, Typography, Box, Grow, IconButton } from "@mui/material";
import { UserContext } from "./userReducer";
import { VisibilityOff, Visibility } from "@mui/icons-material";

export const PasswordInput = ({ onSubmit }: { onSubmit: (password: string) => void }) => {
  const [password, setPassword] = useState("");
  const { user } = useContext(UserContext);
  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(password);
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
          Welcome, {user?.firstName || "Guest"}
        </Typography>
        <form onSubmit={handleSubmit}>
          <TextField
            fullWidth
            label="Password"
            type={showPassword ? "text" : "password"}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
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
            Next
          </Button>
        </form>
      </Box>
    </Grow>
  );
};
export default PasswordInput