
import { Outlet } from "react-router-dom";
import NavBar from "./NavBar";
import { ReactElement } from "react";

const AppLayout = ()=> {
  return (
    <>
      <NavBar />
      <Outlet />
    </>
  );
};

export default AppLayout;