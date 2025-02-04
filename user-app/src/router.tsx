import { createBrowserRouter } from "react-router-dom";
import Home from "./components/Home";
import About from "./components/About";
import AppLayout from "./components/AppLayout";
import RecipesList from "./components/RecipeList";

export const router = createBrowserRouter([
  {
    path: "/",
    element: <AppLayout />,
    children: [
      { path: "/", element: <Home /> },
      { path: "about", element: <About /> },
      { path: "recipes", element:<RecipesList />}


    ],
  },

]);
