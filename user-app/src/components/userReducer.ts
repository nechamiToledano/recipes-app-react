import { Dispatch, createContext } from "react";

export type UserType = {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  address: string;
  phone: string;
} | null;

type Action =
   { type: "CREATE_USER"; data: UserType }
  | { type: "EDIT_USER"; data: Partial<UserType> }
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
    case "CREATE_USER":
      return { ...action.data } as UserType;
      case "EDIT_USER":
        return state ? { ...state, ...action.data } : state;
      
    case "REMOVE_USER":
      return null;
    default:
        return state;
    }
};

export default userReducer;
