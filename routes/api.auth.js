const express = require('express');
const authRoutes = express.Router();
const auth = require('../middleware/auth')
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()
var jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');




authRoutes.post('/auth/login', async(req, res, next) => {
    try {
        const datas = req.body
        const data = await prisma.user.findFirst({where: {email: datas.email}})
       if (!data){
        res.status(404).send({message:"User not found"})
       }else{
        if (!(await bcrypt.compare(String(req.body.password), data.password))){
            res.send({message:"user not found bad credentials"})
        }else{
            let token = await jwt.sign(data, 'fake-jwt-secret')
            res.status(200).json({data,access_token:token, message:"login successfully"})
        }
       }
    } catch (error) {
        next(error);
    }
   
})

authRoutes.use(auth.test).get('/book',  (req, res, next)=>{
    res.json({message: "ok"});
})

module.exports = authRoutes;