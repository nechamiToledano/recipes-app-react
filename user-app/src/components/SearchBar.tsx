import { TextField } from "@mui/material";
import { green } from "@mui/material/colors";

interface SearchBarProps {
  searchTerm: string;
  setSearchTerm: (value: string) => void;
}

const SearchBar = ({ searchTerm, setSearchTerm }: SearchBarProps) => {
  return (
    <TextField
      fullWidth
      variant="outlined"
      placeholder="Search recipes..."
      value={searchTerm}
      onChange={(e) => setSearchTerm(e.target.value)}
      color="success"
      sx={{ mt: 2, borderRadius: 2, boxShadow: 1 }}
    />
  );
};

export default SearchBar;
