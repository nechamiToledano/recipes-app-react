import React, { useContext, useState } from "react";
import { TextField, Button, Typography, Box } from "@mui/material";
import { UserContext } from "./userReducer";

const PasswordInput = ({ onSubmit }: { onSubmit: (password: string) => void;  }) => {
  const [password, setPassword] = useState("");
  const { user, userDispatch } = useContext(UserContext);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(password);
  };

  return (
    <Box>
      <Typography variant="h5" gutterBottom>
        Welcome, {user?.firstName}
      </Typography>
      <form onSubmit={handleSubmit}>
        <TextField
          fullWidth
          label="Password"
          type="password"
          value={password}
          onChange={(e) => setPassword(e.target.value)}
          required
          margin="normal"
        />
        <Button type="submit" variant="contained" fullWidth>
          Next
        </Button>
      </form>
    </Box>
  );
};

export default PasswordInput;
