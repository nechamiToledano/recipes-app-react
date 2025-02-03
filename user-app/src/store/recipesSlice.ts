
import { createAsyncThunk, createSlice } from "@reduxjs/toolkit";
import axios from "axios";
import { string } from "yup";

type Ingredient = {
  product: string;
  quantity: string;
};

type Recipe = {
  id?: number;
  name: string;
  instructions: string;
  ingredients: Ingredient[];
};

export const fetchRecipes = createAsyncThunk("recipes/fetch", async (_, thunkAPI) => {
  try {
    const response = await axios.get("http://localhost:3000/api/recipes");
    return response.data;
  } catch (e: any) {
    return thunkAPI.rejectWithValue(e.message);
  }
});

export const addRecipe = createAsyncThunk("recipes/add", async (recipe: Recipe, thunkAPI) => {
  try {
    const response = await axios.post("http://localhost:3000/api/recipes", recipe);
    return response.data;
  } catch (e: any) {
    return thunkAPI.rejectWithValue(e.message);
  }
});

export const updateRecipe = createAsyncThunk("recipes/update", async (recipe: Recipe, thunkAPI) => {
  try {
    const response = await axios.put(`http://localhost:3000/api/recipes/${recipe.id}`, recipe);
    return response.data;
  } catch (e: any) {
    return thunkAPI.rejectWithValue(e.message);
  }
});

export const deleteRecipe = createAsyncThunk("recipes/delete", async (id: number, thunkAPI) => {
  try {
    await axios.delete(`http://localhost:3000/api/recipes/${id}`);
    return id;
  } catch (e: any) {
    return thunkAPI.rejectWithValue(e.message);
  }
});

const recipesSlice = createSlice({
  name: "recipes",
  initialState: { list: [] as Recipe[], loading: false, error :string },
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
            // state.error = typeof action.payload === 'string' ? action.payload : null;
        })
        .addCase(addRecipe.rejected, (state, action) => {
            // state.error = typeof action.payload === 'string' ? action.payload : null;
        });
}

});

export default recipesSlice;