import React from 'react';
import { Alert } from "@mui/material";

interface AlertsProps {
  error: string | null;
  success: string | null;
}

const Alerts: React.FC<AlertsProps> = ({ error, success }) => (
  <>
    {error && <Alert severity="error" sx={{ mb: 2 }}>{error}</Alert>}
    {success && <Alert severity="success" sx={{ mb: 2 }}>{success}</Alert>}
  </>
);

export default Alerts;
