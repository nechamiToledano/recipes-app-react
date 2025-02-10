import {   Dialog, DialogTitle, DialogContent, TextField,  DialogActions, Button, Typography, IconButton  } from "@mui/material";  
import { useForm, SubmitHandler, useFieldArray } from "react-hook-form";  
import { yupResolver } from "@hookform/resolvers/yup";  
import * as yup from "yup";  
import { RecipeType } from "../models/RecipeType";  
import { Add, Cancel, Remove, CheckCircle } from "@mui/icons-material";  

const RecipeFormModal = ({  
  open,  
  onClose,  
  onSubmit,  
}: { open: boolean; onClose: () => void; onSubmit: SubmitHandler<RecipeType> }  
) => {    
  const recipeSchema = yup.object().shape({  
    title: yup.string().required("שם המתכון חובה"),  
    description: yup.string().required("יש להוסיף תיאור למתכון"),  
    ingredients: yup.array().of(  
      yup.string().required("המרכיב לא יכול להיות ריק")  
    ).min(1, "יש להוסיף לפחות מרכיב אחד"),  
    instructions: yup.string().required("יש להוסיף הוראות הכנה"),  
  });    

  const { register, handleSubmit, control, formState: { errors } } = useForm<RecipeType>({  
    resolver: yupResolver(recipeSchema),  
    defaultValues: {  
      ingredients: [""],  
    }  
  });    

  const { fields, append, remove } = useFieldArray({  
    control,  
    name: "ingredients"  
  });    

  return (  
    <Dialog open={open} onClose={onClose} fullWidth maxWidth="sm">  
      <DialogTitle>{"הוספת מתכון חדש"}</DialogTitle>  
      <DialogContent>  
        <form onSubmit={handleSubmit(onSubmit)}>  
          <TextField  
            {...register("title")}  
            label="שם המתכון"  
            fullWidth  
            sx={{ mb: 2 }}  
            error={!!errors.title}  
            helperText={errors.title?.message}  
          />  
          <TextField  
            {...register("description")}  
            label="תיאור"  
            fullWidth  
            sx={{ mb: 2 }}  
            error={!!errors.description}  
            helperText={errors.description?.message}  
          />  
          <TextField  
            {...register("instructions")}  
            label="הוראות הכנה"  
            fullWidth  
            multiline  
            rows={3}  
            sx={{ mb: 2 }}  
            error={!!errors.instructions}  
            helperText={errors.instructions?.message}  
          />    

          <Typography variant="h6">מרכיבים:</Typography>  
          {fields.map((ingredient, index) => (  
            <div key={ingredient.id} style={{ display: "flex", gap: "10px", marginBottom: "10px" }}>  
              <TextField  
                {...register(`ingredients.${index}`)}  
                label={`מרכיב ${index + 1}`}  
                error={!!errors.ingredients?.[index]}  
                helperText={errors.ingredients?.[index]?.message}  
                fullWidth  
              />  
              <IconButton onClick={() => remove(index)} color="error">     <Remove />   </IconButton>  
            </div>  
          ))}    

          <Button onClick={() => append("")} variant="outlined" color="primary" startIcon={<Add />}>    הוסף מרכיב   </Button>    

          <DialogActions>  
            <Button type="submit" variant="contained" color="success" startIcon={<CheckCircle />}>   שמור   </Button>  
            <Button onClick={onClose} variant='contained' color="error" startIcon={<Cancel />}>   ביטול  </Button>  
          </DialogActions>  
        </form>  
      </DialogContent>  
    </Dialog>  
  );  
};    

export default RecipeFormModal;
