import { Container, Typography, Grid, Card, CardContent, CardMedia, Button } from "@mui/material";
import { fontGrid } from "@mui/material/styles/cssUtils";

const featuredRecipes = [
  { title: "Spaghetti Carbonara", image: "https://media.istockphoto.com/id/1475059886/photo/pasta-spaghetti-with-meat-ball-in-tomato-sauce-top-view.jpg?s=612x612&w=0&k=20&c=oatzuT3seLS3p0iOGY0u2oF7HLkK6hFQGMf6lBS96-k=" },
  { title: "Classic Cheeseburger", image: "https://www.sargento.com/assets/Uploads/Recipe/Image/burgercampNachos_07__FillWzExNzAsNTgzXQ.jpg" },
  { title: "Avocado Toast", image: "https://whatsgabycooking.com/wp-content/uploads/2023/01/Master.jpg" },
];

const Home = () => {
  return (

<Container maxWidth="md" sx={{ mt: 6 }}>
<Card sx={{ p: 10, boxShadow: 3 ,backgroundImage: `url('bg.jpg')`  ,    backgroundSize: 'cover',
  
}}>
  <CardContent>
    <Typography variant="h4" gutterBottom>
      Recipes Site
    </Typography>
    <Typography variant="body1">
    Welcome to Our Recipe Collection

    </Typography>
    <Typography variant="body1" sx={{ mt: 2 }}>
    Discover new flavors and cooking inspiration with our hand-picked recipes. From quick meals to gourmet dishes, we have it all!

    </Typography>
    <Typography variant="body1" sx={{ mt: 2 }}>
    Our mission is to make cooking enjoyable and accessible to all by providing step-by-step guides, cooking tips, and a community of like-minded food enthusiasts.
    </Typography>
    <Typography variant='h6' >
        <Button href="../recipes" >click here and begin cooking😋</Button>
    </Typography>
  </CardContent>
</Card>
</Container>
  );
};

export default Home;
