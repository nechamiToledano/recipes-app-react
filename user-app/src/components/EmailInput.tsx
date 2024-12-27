import React, { useState } from "react";
import { TextField, Button, Typography, Box } from "@mui/material";

const EmailInput = ({ onSubmit }: { onSubmit: (email: string) => void }) => {
  const [email, setEmail] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(email);
  };

  return (
  
    <Box   sx={{
                    p: 4,
                    bgcolor: "background.paper",
                    borderRadius: 2,
                    maxWidth: 400,
                    mx: "auto",
                    mt: 10,
                    boxShadow: 24,
                }}>
      <Typography variant="h6" gutterBottom>
        Sign In
      </Typography>
      <form onSubmit={handleSubmit}>
        <TextField
          fullWidth
          label="Email Address"
          type="email"
          value={email}
          onChange={(e) => setEmail(e.target.value)}
          required
          margin="normal"
        />
        <Button type="submit" fullWidth >
          Next
        </Button>
      </form>
    </Box>
  );
};

export default EmailInput;
