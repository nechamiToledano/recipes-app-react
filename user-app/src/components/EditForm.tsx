import  { useState, useContext } from "react";
import {
  Box,
  Button,
  TextField,
  Typography,
  Paper,
  Grid,
  Alert,
} from "@mui/material";
import { StageContext, UserContext } from "./userReducer";
import axios from "axios";

const FormField = ({ label, name, value, onChange }:{label:any,name:string,value:any,onChange:any}) => (
  <Grid item xs={12}>
    <TextField fullWidth label={label} name={name} value={value} onChange={onChange} variant="outlined" />
  </Grid>
);

const FormFields = ({ formData, handleInputChange }:{formData:any,handleInputChange:any}) => (
  <Grid container spacing={2}>
    {Object.keys(formData).map((key) => (
      <FormField key={key} label={key.charAt(0).toUpperCase() + key.slice(1)} name={key} value={formData[key]} onChange={handleInputChange} />
    ))}
  </Grid>
);

const EditForm = () => {
  const { stage, setStage } = useContext(StageContext);
  const { user, userDispatch } = useContext(UserContext);
  const [formData, setFormData] = useState({
    firstName: user?.firstName || "",
    lastName: user?.lastName || "",
    email: user?.email || "",
    address: user?.address || "",
    phone: user?.phone || "",
  });

  const handleInputChange = (e:any) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({ ...prevData, [name]: value }));
  };

  const handleSubmit = async (e:any) => {
    e.preventDefault();
    if (!user || !user.id) {
      return <Alert severity="error">User ID is missing. Please log in again.</Alert>;
    }
    try {
      const response = await axios.put("http://localhost:3000/api/user", formData, {
        headers: { "user-id": user.id },
      });
      userDispatch({ type: "EDIT", data: response.data });
      setStage("home");
    } catch (error) {
      return <Alert severity="error">An error occurred while updating your profile.</Alert>;
    }
  };

  return (
    <Box sx={{ display: "flex", justifyContent: "center", alignItems: "center", minHeight: "100vh", backgroundColor: "#f4f4f4", padding: 2 }}>
      <Paper elevation={3} sx={{ width: "100%", maxWidth: 500, padding: 3, borderRadius: 2 }}>
        <Typography variant="h5" fontWeight="600" marginBottom={2}>Edit Profile</Typography>
        <form onSubmit={handleSubmit}>
          <FormFields formData={formData} handleInputChange={handleInputChange} />
          <Box sx={{ display: "flex", justifyContent: "space-between", marginTop: 3 }}>
            <Button type="submit" variant="contained" color="success" sx={{ width: "48%" }}>Save</Button>
          </Box>
        </form>
      </Paper>
    </Box>
  );
};

export default EditForm;
