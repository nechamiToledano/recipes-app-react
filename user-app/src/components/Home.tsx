import { Container, Typography, Grid, Card, CardContent, CardMedia, Button } from "@mui/material";

const featuredRecipes = [
  { title: "Spaghetti Carbonara", image: "https://source.unsplash.com/400x300/?pasta" },
  { title: "Classic Cheeseburger", image: "https://source.unsplash.com/400x300/?burger" },
  { title: "Avocado Toast", image: "https://source.unsplash.com/400x300/?avocado-toast" },
];

const Home = () => {
  return (
    <Container maxWidth="lg" sx={{ mt: 4 }}>
      <Typography variant="h3" gutterBottom>
        Welcome to Our Recipe Collection
      </Typography>
      <Typography variant="body1" paragraph>
        Discover new flavors and cooking inspiration with our hand-picked recipes. From quick meals to gourmet dishes, we have it all!
      </Typography>

      <Grid container spacing={3} sx={{ mt: 3 }}>
        {featuredRecipes.map((recipe, index) => (
          <Grid item xs={12} sm={6} md={4} key={index}>
            <Card sx={{ boxShadow: 3 }}>
              <CardMedia component="img" height="200" image={recipe.image} alt={recipe.title} />
              <CardContent>
                <Typography variant="h6">{recipe.title}</Typography>
                <Button variant="contained" color="primary" sx={{ mt: 2 }} fullWidth>
                  View Recipe
                </Button>
              </CardContent>
            </Card>
          </Grid>
        ))}
      </Grid>
    </Container>
  );
};

export default Home;
