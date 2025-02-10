import { Dialog, DialogTitle, DialogContent, DialogActions, Button, Typography, CardMedia, Box } from "@mui/material";
import { RecipeType } from "../models/RecipeType";

interface RecipeModalProps {
  recipe: RecipeType | null;
  onClose: () => void;
}

const RecipeModal = ({ recipe, onClose }: RecipeModalProps) => (
  <Dialog open={!!recipe} onClose={onClose} fullWidth maxWidth="md">
    {recipe && (
      <>
        <DialogTitle sx={{ textAlign: "center", fontWeight: 700, fontSize: "1.8rem", color: "primary.main" }}>
          {recipe.title}
        </DialogTitle>
        <DialogContent sx={{ p: 3 }}>
          { (
            <CardMedia
              component="img"
              height="300"
         image={'food.png'}
            
              alt={recipe.title}
              sx={{
                objectFit: "cover",
                mb: 3,
                borderRadius: "12px",
                boxShadow: 2,
              }}
            />
          )}

          <Typography variant="h6" sx={{ fontWeight: 600, mt: 2 }}>
            תיאור:
          </Typography>
          <Typography sx={{ fontSize: "1rem", mb: 2 }}>{recipe.description}</Typography>

          <Typography variant="h6" sx={{ fontWeight: 600, mt: 2 }}>
            מצרכים:
          </Typography>
          <Box
            component="ul"
            sx={{
              listStyle: "none",
              p: 0,
              m: 0,
              "& li": {
                background: "#f5f5f5",
                borderRadius: "8px",
                padding: "6px 12px",
                marginBottom: "5px",
              },
            }}
          >
            {recipe.ingredients.map((ing, index) => (
              <li key={index}>{ing}</li>
            ))}
          </Box>

          <Typography variant="h6" sx={{ fontWeight: 600, mt: 2 }}>
            הוראות הכנה:
          </Typography>
          <Typography sx={{ fontSize: "1rem", mb: 2 }}>{recipe.instructions}</Typography>
        </DialogContent>

        <DialogActions sx={{ justifyContent: "center", pb: 2 }}>
          <Button
            onClick={onClose}
            color="success"
            variant="contained"
            sx={{
              borderRadius: "20px",
              fontSize: "1rem",
              padding: "8px 20px",
              boxShadow: 2,
            }}
          >
            סגור
          </Button>
        </DialogActions>
      </>
    )}
  </Dialog>
);

export default RecipeModal;
