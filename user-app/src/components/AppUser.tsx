import { createContext, useContext, useReducer, useState } from "react";
import { CssBaseline, Container, Box, Button } from "@mui/material";
import EmailInput from "./EmailInput";
import PasswordInput from "./PasswordInput";
import RegistrationForm from "./RegistrationForm";
import HomePage from "./HomePage";
import userReducer, { UserContext, UserType } from "./userReducer";
import LoginIcon from '@mui/icons-material/Login';

const AppUser = () => {
  const initialState: UserType = null;
  const [user, userDispatch] = useReducer(userReducer, initialState);
  const [stage, setStage] = useState<"login" | "email" | "password" | "register" |"edit"| "home">("login");
  const [email, setEmail] = useState("");

  const handleEmailSubmit = (email: string) => {
    setEmail(email);
    console.log(user);
    setStage(user?.email === email ? "password" : "register");
  };

  const handlePasswordSubmit = (password: string) => {

    if (user?.password === password) {
      userDispatch({ type: "LOGIN", data: user });
      setStage("home");
    } else {
      alert("Invalid password");
    }
  };

  const handleRegister = () => {
    setStage("home");
  };

  const handleLogout = () => {
    setStage("login");
  };
  const handleEdit = () => {
    setStage("edit");
  };
  return (
 <UserContext.Provider  value={{ user,userDispatch }}>
    
    <CssBaseline>
      {stage === "login" && <Button variant="contained" onClick={() => { setStage("email")}} endIcon={<LoginIcon />}>Login</Button>}
      <Container maxWidth="sm">
        <Box mt={5}>
          {stage === "email" && <EmailInput onSubmit={handleEmailSubmit} />}
          {stage === "password" && <PasswordInput onSubmit={handlePasswordSubmit} email={email} />}
          {stage === "register" && <RegistrationForm onSubmit={handleRegister} email={email} />}
          {stage === "edit" && <RegistrationForm onSubmit={handleRegister} email={email} />}
          {stage === "home" && <HomePage onLogout={handleLogout} onEdit={handleEdit}/>}
        </Box>
      </Container>
    </CssBaseline>
    </UserContext.Provider>
  );
};

export default AppUser;
