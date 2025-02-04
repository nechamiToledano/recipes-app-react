import { Container, Typography, Card, CardContent } from "@mui/material";

const About= () => {
  return (
    <Container maxWidth="md" sx={{ mt: 4 }}>
<Card sx={{ p: 10, boxShadow: 3 ,backgroundImage: `url('bg.jpg')`  ,    backgroundSize: 'cover'}}>
        <CardContent>
          <Typography variant="h4" gutterBottom>
            About Us
          </Typography>
          <Typography variant="body1">
            Welcome to our recipe site! We are passionate about sharing delicious and easy-to-make recipes with food lovers everywhere. 
            Whether you’re a beginner or a seasoned cook, our curated collection has something for everyone.
          </Typography>
          <Typography variant="body1" sx={{ mt: 2 }}>
            Our mission is to make cooking enjoyable and accessible to all by providing step-by-step guides, cooking tips, 
            and a community of like-minded food enthusiasts.
          </Typography>
        </CardContent>
      </Card>
    </Container>
  );
};

export default About;
