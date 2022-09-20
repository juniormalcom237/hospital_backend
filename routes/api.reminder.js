const express = require('express');
const reminderRoutes = express.Router();
const auth = require('../middleware/auth')
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();

reminderRoutes.use(auth.test).post('/reminder', async (req, res, next)=>{
    try {
        
    } catch (error) {
        next(error);
    }
})

module.exports = reminderRoutes;