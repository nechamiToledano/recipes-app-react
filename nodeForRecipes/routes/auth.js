import express from 'express';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import authMiddleware from '../middleware/authMiddleware.js';

const router = express.Router();
const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const dbPath = path.join(__dirname, '../db/db.json');

// רישום משתמש חדש
router.post('/register', (req, res) => {
    const { email, password } = req.body;
    const db = JSON.parse(fs.readFileSync(dbPath));

    if (db.users.find(user => user.email === email)) {
        return res.status(400).json({ message: "User already exists" });
    }

    const newUser = {
        id: Date.now(),
        email,
        password  // במציאות – להצפין סיסמא
    };

    db.users.push(newUser);
    fs.writeFileSync(dbPath, JSON.stringify(db, null, 2));

    res.status(201).json({ message: "User registered successfully", userId: newUser.id });
});

// התחברות
router.post('/login', (req, res) => {
    const { email, password } = req.body;
    const db = JSON.parse(fs.readFileSync(dbPath));

    const user = db.users.find(user => user.email === email && user.password === password);

    if (!user) {
        return res.status(401).json({ message: "Invalid credentials" });
    }

    res.json({ message: "Login successful", user });
});

router.put('/', authMiddleware, (req, res) => {
    const { firstName, lastName, email, address, phone } = req.body;
    const id = parseInt(req.header('user-id'));

    const db = JSON.parse(fs.readFileSync(dbPath));

    const user = db.users.find(user => user.id === id);

    if (!user) {
        return res.status(404).json({ message: "User not found" });
    }

    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    user.address = address;
    user.phone = phone;

    fs.writeFileSync(dbPath, JSON.stringify(db, null, 2));

    res.json(user);
   
   
});
export default router;
