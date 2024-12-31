import React, { useState } from "react";
import { TextField, Button, Typography, Box, Grow } from "@mui/material";

export const EmailInput = ({ onSubmit }: { onSubmit: (email: string) => void }) => {
  const [email, setEmail] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    onSubmit(email);
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
            variant="outlined"
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
export default EmailInput