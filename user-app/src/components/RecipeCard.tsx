import { Card, CardContent, CardMedia, Button, Typography } from "@mui/material";
import { RecipeType } from "../models/RecipeType";

interface RecipeCardProps {
  recipe: RecipeType;
  onClick: () => void;
}

const RecipeCard = ({ recipe, onClick }: RecipeCardProps) => (
  <Card sx={{ boxShadow: 3, borderRadius: 2 }}>
    <CardMedia
      component="img"
      height="200"
      image={'food.png'}
      alt={recipe.title}
      sx={{ objectFit: "cover" }}
    />
    <CardContent>
      <Typography variant="h6">{recipe.title}</Typography>
      <Button
        variant="contained"
        color="success"
        sx={{ mt: 2 }}
        fullWidth
        onClick={onClick}
      >
        צפה במתכון
      </Button>
    </CardContent>
  </Card>
);

export default RecipeCard;
