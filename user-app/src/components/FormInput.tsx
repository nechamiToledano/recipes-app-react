import React from 'react';
import { TextField, IconButton } from "@mui/material";
import { Visibility, VisibilityOff } from "@mui/icons-material";

interface FormInputProps {
  label: string;
  name: string;
  type: string;
  value: string;
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  showPassword?: boolean;
  togglePasswordVisibility?: () => void;
}

const FormInput: React.FC<FormInputProps> = ({
  label,
  name,
  type,
  value,
  onChange,
  showPassword,
  togglePasswordVisibility,
}) => (
  <TextField
    label={label}
    name={name}
    type={type}
    value={value}
    onChange={onChange}
    fullWidth
    required
    margin="normal"
    variant="outlined"
    InputProps={showPassword && togglePasswordVisibility ? {
      endAdornment: (
        <IconButton onClick={togglePasswordVisibility}>
          {showPassword ? <VisibilityOff /> : <Visibility />}
        </IconButton>
      ),
    } : {}}
  />
);

export default FormInput;
