import { useDispatch, useSelector } from "react-redux";
import { fetchRecipes, addRecipe } from "../store/recipesSlice";
import { useContext, useEffect, useState } from "react";
import { Container, Grid, Button, Card, CardContent, Typography, Box } from "@mui/material";
import { RootState } from "../store/store";
import { RecipeType } from "../models/RecipeType";
import { UserContext } from "./userReducer";
import RecipeCard from "./RecipeCard";
import RecipeFormModal from "./RecipeFormModal";
import { Add, Padding } from "@mui/icons-material";

const RecipesList = () => {
  const { list: recipesList, loading, error } = useSelector((state: RootState) => state.recipes);
  const dispatch = useDispatch();
  const [selectedRecipe, setSelectedRecipe] = useState<RecipeType | null>(null);
  const [openFormModal, setOpenFormModal] = useState(false);

  const { user } = useContext(UserContext);

  const openForm = () => {
    setOpenFormModal(true);
  };
 
  const onSubmit = async( data:Omit<RecipeType, 'id' | 'authorId'>) => {
    try {
      const recipeToAdd = {
        ...data,
        authorId: user?.id,
        ingredients: data.ingredients || []
      };
      
      await dispatch(addRecipe(recipeToAdd  as RecipeType) as any);
      dispatch(fetchRecipes() as any);
      setOpenFormModal(false);
    } catch (error) {
      console.error("Error adding recipe:", error);
    }
  };

  useEffect(() => {
    dispatch(fetchRecipes() as any);
  }, [dispatch]);

  return (
    <Container maxWidth="lg" sx={{ mt: 4 }}>
      <Card sx={{ p: 5, boxShadow: 3, backgroundImage: `url('bg.jpg')`, backgroundSize: 'cover' }}>
        <CardContent>
          <Typography variant="h3" fontWeight={600} sx={{ color: 'green' }}>
           מתכונים מומלצים
          </Typography>
          {user && (
            <Button variant='outlined' color="success" sx={{margin:'15px' }} onClick={() => openForm()}>
              <Add/> הוספת מתכון
            </Button>
          )}
        </CardContent>
      </Card>

      {loading && <Typography>טוען מתכונים...</Typography>}
      {error && <Typography color="error">{error}</Typography>}

      <Grid container spacing={3} sx={{ mt: 3 }}>
        {/* כרטיסים בצד ימין (2/3 מהרוחב) */}
        <Grid item xs={12} md={8}>
          <Grid container spacing={3}>
            {recipesList.map((recipe) => (
              <Grid item xs={12} sm={6} md={4} key={recipe.id}>
                <RecipeCard recipe={recipe} onClick={() => setSelectedRecipe(recipe)} />
              </Grid>
            ))}
          </Grid>
        </Grid>

        {/* הצגת המתכון בצד שמאל (1/3 מהרוחב) */}
        <Grid item xs={12} md={4}>
          {selectedRecipe ? (
            <Card sx={{ p: 2, boxShadow: 3 }}>
              <Typography variant="h5">{selectedRecipe.title}</Typography>
              <Typography variant="body1" sx={{ mt: 2 }}>{selectedRecipe.description}</Typography>
              <Typography variant="h6" sx={{ mt: 2 }}>מצרכים:</Typography>
              <ul>
                {selectedRecipe.ingredients.map((ing, index) => (
                  <li key={index}>{ing}</li>
                ))}
              </ul>
              <Typography variant="h6" sx={{ mt: 2 }}>הוראות הכנה:</Typography>
              <Typography>{selectedRecipe.instructions}</Typography>
            </Card>
          ) : (
            <Typography variant="h6" sx={{ textAlign: "center", mt: 5 }}>בחר מתכון להצגה</Typography>
          )}
        </Grid>
      </Grid>

      <RecipeFormModal open={openFormModal} onClose={() => setOpenFormModal(false)} onSubmit={onSubmit} />
    </Container>
  );
};

export default RecipesList;
