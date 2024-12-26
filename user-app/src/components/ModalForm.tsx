import { Modal, Box, Typography, TextField, Button, FilledInput, Input, styled } from "@mui/material";
import { useRef, FormEvent } from "react";
import { UserType } from "./userReducer";
import CloudUploadIcon from '@mui/icons-material/CloudUpload';
const VisuallyHiddenInput = styled('input')({
    clip: 'rect(0 0 0 0)',
    clipPath: 'inset(50%)',
    height: 1,
    overflow: 'hidden',
    position: 'absolute',
    bottom: 0,
    left: 0,
    whiteSpace: 'nowrap',
    width: 1,
  });
const ModalForm = ({
    open,
    onClose,
    onLogin,
    onSubmit,
    isEditMode,
    existingData,
}: {
    open: boolean;
    onClose: () => void;
    onLogin: (data: UserType) => void;
    onSubmit: (data: Partial<UserType>) => void;
    isEditMode: boolean;
    existingData?: UserType | null;
}) => {
    const firstNameRef = useRef<HTMLInputElement>(null);
    const lastNameRef = useRef<HTMLInputElement>(null);
    const emailRef = useRef<HTMLInputElement>(null);
    const addressRef = useRef<HTMLInputElement>(null);
    const passwordRef = useRef<HTMLInputElement>(null);
    const phoneRef = useRef<HTMLInputElement>(null);

    const handleSubmit = (e: FormEvent) => {
        e.preventDefault();

        const data = {
            firstName: firstNameRef.current?.value || null,
            lastName: lastNameRef.current?.value || null,
            email: emailRef.current?.value || null,
            address: addressRef.current?.value || null,
            password: passwordRef.current?.value || null,
            phone: phoneRef.current?.value || null,
        };

        if (isEditMode) {
            onSubmit(data as Partial<UserType>); // Submit only non-null fields
        } else {
            onLogin(data as UserType); // Login requires full data
        }
        onClose();
    };

    return (
        <Modal open={open} onClose={onClose}>
            <Box
                sx={{
                    p: 4,
                    bgcolor: "background.paper",
                    borderRadius: 2,
                    maxWidth: 400,
                    mx: "auto",
                    mt: 10,
                    boxShadow: 24,
                }}
            >
                <Typography variant="h6" mb={2}>
                    {isEditMode ? "Edit Profile" : "Login"}
                </Typography>
                <form onSubmit={handleSubmit}>
                    <Box display="flex" flexDirection="column" gap={2}>
                        <TextField
                            variant="filled"
                            label="First Name"
                            inputRef={firstNameRef}
                            defaultValue={existingData?.firstName || ""}
                            fullWidth
                            required
                        />
                        <TextField
                            variant="filled"
                            label="Last Name"
                            inputRef={lastNameRef}
                            defaultValue={existingData?.lastName || ""}
                            fullWidth
                            required

                        />
                        <TextField

                            variant="filled"
                            label="Email"
                            inputRef={emailRef}
                            defaultValue={existingData?.email || ""}
                            type="email"
                            fullWidth
                            required
                        />
                        <TextField
                            variant="filled"
                            label="Address"
                            inputRef={addressRef}
                            defaultValue={existingData?.address || ""}
                            fullWidth
                            required
                        />
                        <TextField
                            variant="filled"
                            label="Password"
                            inputRef={passwordRef}
                            type="password"
                            fullWidth
                            required
                        />
                        <TextField
                            variant="filled"
                            label="Phone"
                            inputRef={phoneRef}
                            defaultValue={existingData?.phone || ""}
                            fullWidth
                            required
                        />
                        <Button
                            component="label"
                            role={undefined}
                            variant="contained"
                            tabIndex={-1}
                            startIcon={<CloudUploadIcon />}
                            
                        >
                            Upload Image
                            <VisuallyHiddenInput
                                type="file"
                                onChange={(event: { target: { files: any; }; }) => console.log(event.target.files)}
                                multiple
                            />
                        </Button>
                        <Button type="submit" variant="contained" fullWidth>
                            Submit
                        </Button>
                    </Box>
                </form>
            </Box>
        </Modal>
    );
};

export default ModalForm;
