import { useDispatch, useSelector } from "react-redux";
import { fetchRecipes, addRecipe } from "../store/recipesSlice";
import { useContext, useEffect, useState } from "react";
import { Container, Grid, Button, Card, CardContent, Typography } from "@mui/material";
import { RootState } from "../store/store";
import { RecipeType } from "../models/RecipeType";
import { UserContext } from "./userReducer";
import RecipeCard from "./RecipeCard";
import RecipeModal from "./RecipeModal";
import RecipeFormModal from "./RecipeFormModal";

const RecipesList = () => {
  const { list: recipesList, loading, error } = useSelector((state: RootState) => state.recipes);
  const dispatch = useDispatch();
  const [selectedRecipe, setSelectedRecipe] = useState<RecipeType | null>(null);
  const [openFormModal, setOpenFormModal] = useState(false);
  const [imagePreview, setImagePreview] = useState<string | null>(null);

  const { user } = useContext(UserContext);

  const openForm = () => {
    setOpenFormModal(true);
  };

  const onSubmit = async (data: Omit<RecipeType, 'id' | 'authorId'>) => {
    console.log(user?.userId);
    
    try {
      const recipeToAdd = {
        ...data,
        authorId: user?.userId,
      };
      console.log(recipeToAdd.authorId);
      
      await dispatch(addRecipe(recipeToAdd as unknown as RecipeType) as any);
      dispatch(fetchRecipes() as any);
      setOpenFormModal(false);
    } catch (error) {
      console.error("Error adding recipe:", error);
    }
  };

  useEffect(() => {
    dispatch(fetchRecipes() as any);
  }, [dispatch]);

  function setValue(field: string, value: any): void {
  }

  return (
    <Container maxWidth="md">
            <Container maxWidth="md" sx={{ mt: 4 }}>
        <Card sx={{ p: 5, boxShadow: 3, backgroundImage: `url('bg.jpg')`, backgroundSize: 'cover' }}>
          <CardContent>
            <Typography variant="h4" gutterBottom>
              Our Recipes
            </Typography>

            <Typography variant="body1" sx={{ mt: 8 }}>
              {user && (
               <Button variant='outlined' color="success" onClick={() => openForm()}>
                ➕ הוספת מתכון
              </Button>
              )}
            </Typography>
          </CardContent>
        </Card>
      </Container>
      {loading && <Typography>טוען מתכונים...</Typography>}
      {error && <Typography color="error">{error}</Typography>}

      <Grid container spacing={3} sx={{ mt: 3 }}>
        {recipesList.map((recipe) => (
          <Grid item xs={12} sm={6} md={4} key={recipe.id}>
            <RecipeCard recipe={recipe} onClick={() => setSelectedRecipe(recipe)} />
          </Grid>
        ))}
      </Grid>

      <RecipeModal recipe={selectedRecipe} onClose={() => setSelectedRecipe(null)} />
      <RecipeFormModal open={openFormModal} onClose={() => setOpenFormModal(false)} onSubmit={onSubmit} imagePreview={imagePreview} setImagePreview={setImagePreview} setValue={setValue} />
    </Container>
  );
};

export default RecipesList;
