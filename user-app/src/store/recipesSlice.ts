import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";
import { RecipeType } from "../models/RecipeType"; // Assuming you have the types defined

export const fetchRecipes = createAsyncThunk("recipes/fetch", async (_, thunkAPI) => {
  try {
    const response = await axios.get("http://localhost:3000/api/recipes");
    return response.data; // Assuming the API returns an array of recipes
  } catch (e: any) {
    return thunkAPI.rejectWithValue(e.message);
  }
});

export const addRecipe = createAsyncThunk("recipes/add", async (recipe: RecipeType, thunkAPI) => {
  try {
    const response = await axios.post("http://localhost:3000/api/recipes", {
      title: recipe.title,
      description: recipe.description,
      ingredients: recipe.ingredients,
      instructions: recipe.instructions,
      authorId: recipe.authorId,
  }, {
      headers: { "user-id": recipe.authorId.toString() }, // Add proper user-id header for authenticated users
    });
    return response.data.recipe; // Assuming the API returns the created recipe
  } catch (e: any) {
    return thunkAPI.rejectWithValue(e.message);
  }
});


const recipesSlice = createSlice({
  name: "recipes",
  initialState: { list: [] as RecipeType[], loading: false, error: null as string | null },
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(fetchRecipes.pending, (state) => {
        state.loading = true;
      })
      .addCase(fetchRecipes.fulfilled, (state, action) => {
        state.loading = false;
        state.list = action.payload;
      })
      .addCase(fetchRecipes.rejected, (state, action) => {
        state.loading = false;
        state.error = action.payload as string;
      })
      .addCase(addRecipe.fulfilled, (state, action) => {
        state.list.push(action.payload);
      })

      .addCase(addRecipe.rejected, (state, action) => {
        state.error = action.payload as string;
      })

  },
});

export default recipesSlice;
