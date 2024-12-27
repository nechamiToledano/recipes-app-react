import { Dispatch, createContext } from "react";

export type UserType = {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  address: string;
  phone: string;
  imagePreview: string;
} | null;

type Action =
  | { type: "LOGIN"; data: UserType }
  | { type: "EDIT"; data: Partial<UserType> }|
  { type: "LOGOUT"; }|
  { type: "REGISTER"; data: UserType}
  | { type: "REMOVE_USER" };

export const UserContext = createContext<{
  user: UserType;
  userDispatch: Dispatch<Action>;
}>({
  user: null,
  userDispatch: () => null,
});

const userReducer = (state: UserType, action: Action): UserType => {
  switch (action.type) {
  
      case "REGISTER":
        return { ...action.data } as UserType;
    case "EDIT":
      return state ? { ...state, ...action.data } : state;

    case "REMOVE_USER":
      return null;
    default:
      return state;
  }
};

export default userReducer;
