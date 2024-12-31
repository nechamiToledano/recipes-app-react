import { useContext, useReducer, useState } from "react";
import {
    CssBaseline,
    Container,
    Box,
    Button,
 
} from "@mui/material";
import EmailInput from "./EmailInput";
import PasswordInput from "./PasswordInput";
import RegistrationForm from "./RegistrationForm";
import HomePage from "./HomePage";
import userReducer, { UserContext, UserType, StageContext, StageType } from "./userReducer";
import LoginIcon from "@mui/icons-material/Login";

const AppUser = () => {
    const initialState: UserType = null;
    const [user, userDispatch] = useReducer(userReducer, initialState);

    // Use state for stage management
    const [stage, setStage] = useState<StageType>("login");
    const [email, setEmail] = useState("");

    // Handle email submission
    const handleEmailSubmit = (email: string) => {
        setEmail(email);
        if(user?.email!==email) {
            userDispatch({type:"REMOVE_USER"});
            setStage("register")
        }
        else setStage("password");
    };

    // Handle password submission
    const handlePasswordSubmit = (password: string) => {
        if (user?.password === password) {
            userDispatch({ type: "LOGIN", data: user });
            setStage("home");
        } else {
            alert("Invalid password");
        }
    };

    return (
        <UserContext.Provider value={{ user, userDispatch }}>
            <StageContext.Provider value={{ stage, setStage }}>
                <CssBaseline />
                <Container>

                    {stage === "login" && (
                        <Box
                            sx={{
                                position: "absolute",
                                top: 20,
                                left: 20,
                            }}
                        >
                            <Button
                                variant="contained"
                                color="primary"
                                size="large"
                                onClick={() => setStage("email")}
                                endIcon={<LoginIcon />}
                                sx={{
                                    py: 1.5,
                                    textTransform: "none",
                                    fontSize: "1.1rem",
                                }}
                            >
                                Login
                            </Button>
                        </Box>
                    )}

                    { stage === "home" && <HomePage />}

                    {stage === "email" && (
                        <Box mt={3}>
                            <EmailInput onSubmit={handleEmailSubmit} />
                        </Box>
                    )}

                    {stage === "password" && (
                        <Box mt={3}>
                            <PasswordInput onSubmit={handlePasswordSubmit} />
                        </Box>
                    )}

                    {stage === "register" && (
                        <Box mt={3}>
                            <RegistrationForm email={email} />
                        </Box>
                    )}

                    {stage === "edit" && (
                        <Box mt={3}>
                            <RegistrationForm email={email} />
                        </Box>
                    )}

                </Container>
            </StageContext.Provider>
        </UserContext.Provider>
    );
};

export default AppUser;
