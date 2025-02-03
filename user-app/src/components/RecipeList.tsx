import { useDispatch, useSelector } from "react-redux";
import { fetchRecipes, addRecipe, updateRecipe, deleteRecipe } from "../store/recipesSlice";
import { useEffect, useState } from "react";
import { useForm, useFieldArray } from "react-hook-form";
import { yupResolver } from "@hookform/resolvers/yup";
import * as yup from "yup";
import { RootState } from "../store";
import {
  Container,
  Card,
  CardContent,
  Typography,
  Button,
  TextField,
  Grid,
  Box,
} from "@mui/material";

const recipeSchema = yup.object().shape({
  name: yup.string().required("שם המתכון חובה"),
  instructions: yup.string().required("יש להוסיף הוראות הכנה"),
  ingredients: yup
    .array()
    .of(
      yup.object().shape({
        product: yup.string().required("שם המוצר חובה"),
        quantity: yup.string().required("יש להוסיף כמות"),
      })
    )
    .min(1, "יש להוסיף לפחות מרכיב אחד"),
});

const RecipesList = () => {
  const { list: recipesList, loading, error } = useSelector(
    (state: RootState) => state.recipes
  );
  const dispatch = useDispatch();
  const [searchTerm, setSearchTerm] = useState("");
  const [editingRecipe, setEditingRecipe] = useState(null);

  const {
    register,
    handleSubmit,
    control,
    reset,
    formState: { errors },
  } = useForm({
    resolver: yupResolver(recipeSchema),
    defaultValues: {
      name: "",
      instructions: "",
      ingredients: [{ product: "", quantity: "" }],
    },
  });

  const { fields, append, remove } = useFieldArray({
    control,
    name: "ingredients",
  });

  useEffect(() => {
    dispatch(fetchRecipes() as any);
  }, [dispatch]);

  const onSubmit = async (data: any) => {
    if (editingRecipe) {
      await dispatch(updateRecipe({ id: editingRecipe.id, ...data }) as any);
      setEditingRecipe(null);
    } else {
      await dispatch(addRecipe(data) as any);
    }
    reset();
  };

  const filteredRecipes = recipesList.filter(recipe => 
    recipe.name.toLowerCase().includes(searchTerm.toLowerCase())
  );

  return (
    <Container maxWidth="md">
      <Typography variant="h3" gutterBottom>
        מתכונים
      </Typography>

      <TextField 
        fullWidth 
        label="חיפוש מתכון" 
        value={searchTerm} 
        onChange={(e) => setSearchTerm(e.target.value)}
        sx={{ mb: 2 }}
      />

      {loading && <Typography>טוען מתכונים...</Typography>}
      {error && <Typography color="error">{error}</Typography>}

      {filteredRecipes.map((recipe) => (
        <Card key={recipe.id} sx={{ mb: 2, boxShadow: 3 }}>
          <CardContent>
            <Typography variant="h5">{recipe.name}</Typography>
            <Typography>{recipe.instructions}</Typography>
            <Typography variant="subtitle1" sx={{ mt: 2 }}>מצרכים:</Typography>
            <ul>
              {recipe.ingredients.map((ing, i) => (
                <li key={i}>{ing.product} - {ing.quantity}</li>
              ))}
            </ul>
            <Box sx={{ mt: 2, display: "flex", gap: 2 }}>
              <Button variant="outlined" onClick={() => setEditingRecipe(recipe)}>✏️ עריכה</Button>
              <Button variant="outlined" color="error" onClick={() => dispatch(deleteRecipe(recipe.id) as any)}>❌ מחק</Button>
            </Box>
          </CardContent>
        </Card>
      ))}

      <Button
        variant="contained"
        color="primary"
        onClick={() => setEditingRecipe({ name: "", instructions: "", ingredients: [] })}
      >
        ➕ הוספת מתכון
      </Button>

      {editingRecipe && (
        <Card sx={{ mt: 3, p: 3, boxShadow: 3 }}>
          <Typography variant="h5" gutterBottom>
            {editingRecipe.id ? "עריכת מתכון" : "הוספת מתכון חדש"}
          </Typography>
          <form onSubmit={handleSubmit(onSubmit)}>
            <TextField
              {...register("name")}
              label="שם המתכון"
              fullWidth
              error={!!errors.name}
              helperText={errors.name?.message}
              sx={{ mb: 2 }}
            />
            <TextField
              {...register("instructions")}
              label="הוראות הכנה"
              fullWidth
              multiline
              rows={3}
              error={!!errors.instructions}
              helperText={errors.instructions?.message}
              sx={{ mb: 2 }}
            />

            <Typography variant="h6">מצרכים:</Typography>
            {fields.map((field, index) => (
              <Grid container spacing={2} key={field.id} alignItems="center">
                <Grid item xs={5}>
                  <TextField
                    {...register(`ingredients.${index}.product`)}
                    label="שם המוצר"
                    fullWidth
                    error={!!errors.ingredients?.[index]?.product}
                    helperText={errors.ingredients?.[index]?.product?.message}
                  />
                </Grid>
                <Grid item xs={5}>
                  <TextField
                    {...register(`ingredients.${index}.quantity`)}
                    label="כמות"
                    fullWidth
                    error={!!errors.ingredients?.[index]?.quantity}
                    helperText={errors.ingredients?.[index]?.quantity?.message}
                  />
                </Grid>
                <Grid item xs={2}>
                  <Button variant="outlined" color="error" onClick={() => remove(index)}>❌</Button>
                </Grid>
              </Grid>
            ))}

            <Box sx={{ mt: 2 }}>
              <Button variant="outlined" onClick={() => append({ product: "", quantity: "" })}>
                ➕ הוספת מרכיב
              </Button>
            </Box>

            <Box sx={{ mt: 3, display: "flex", gap: 2 }}>
              <Button type="submit" variant="contained" color="success">
                ✅ שמירה
              </Button>
              <Button variant="outlined" color="secondary" onClick={() => setEditingRecipe(null)}>
                ❌ ביטול
              </Button>
            </Box>
          </form>
        </Card>
      )}
    </Container>
  );
};

export default RecipesList;
