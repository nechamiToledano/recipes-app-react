import { Dispatch, createContext } from "react";

export type StageType ="login" | "navigation"| "register" |"edit"| "home";

export const UserContext = createContext<{
  user: UserType;
  userDispatch: Dispatch<Action>;
}>({
  user: null,
  userDispatch: () => null,
});


export const StageContext = createContext<{
    stage: StageType;
    setStage: (stage: StageType) => void;
}>({
    stage: "navigation",
    setStage: () => {},
});


export type UserType = {
  id: number;
  email?: string;
  password?: string;
  firstName?: string;
  lastName?: string;
  address?: string;
  phone?: string;
} | null; 

type Action =
  | { type: "LOGIN"; data: UserType } // Password not needed in context
  | { type: "REGISTER"; data: UserType }
  | { type: "EDIT"; data: Partial<UserType> }
  | { type: "LOGOUT" }
  | { type: "REMOVE_USER" };

export const userReducer = (state:UserType, action: Action) => {
  switch (action.type) {
    case "LOGIN":
    case "REGISTER":
      return { ...action.data ,
        firstName: action.data?.firstName || "User",
        id: action.data?.id || "",        
      }; 
    case "EDIT":
      return state ? { ...state, ...action.data } : state;
    case "LOGOUT":
    case "REMOVE_USER":
      return null;
    default:
      return state;
  }
};


export default userReducer;
