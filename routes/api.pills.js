const express = require('express');
const pillsRoutes = express.Router();
const auth = require('../middleware/auth')
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();
pillsRoutes.use(auth.test).post('/pills', async (req, res, next)=>{
    try {
        const data = req.body;
        console.log(data);
        let reqData;
        if(data.time == ""){
                reqData = await prisma.pills.create({data: {
                    name: data.name,
                    amount: data.amount,
                    howLong: data.howLong,
                    days: data.days,
                    userUserId: data.userUserId,
                    medicineFormMedicalRecordId: Number(data.medicineForm),
                    
                }, 
                
                
            });
            console.log("Ok")
            res.status(200).json({reqData, message: "Pills Successfully added"});
       }else{
        reqData = await prisma.medicineReminder.create({
            data: {
                Time: new Date(data.time),
                userUserId: Number(data.userUserId),
            }
        })
        reqData = await prisma.pills.create({
            data:{
                name: data.name,
                amount: data.amount,
                howLong: data.howLong,
                days: data.days,
                userUserId: data.userUserId,
                medicineReminderMedicalRecordId: reqData.medicalRecordId,
                medicineFormMedicalRecordId: Number(data.medicineForm),
            }
        })
        res.json({reqData, message: "Pills Registered and Reminder Set"});
       }
       
       
       
    }catch(error){
        next(error);
    }
});


pillsRoutes.use(auth.test).get('/pills/:id', async (req, res, next)=>{
    try {
      
        reqData = await prisma.pills.findUnique({
            where: {
                pills: Number(req.params.id)
            }
        //include:{
        //     Doctor: true,
        //     Patient: true,
        // }
    });
    res.status(200).json({reqData});
       
    }catch(error){
        next(error);
    }
})
pillsRoutes.use(auth.test).get('/pills', async (req, res, next)=>{
    try {
        
        reqData = await prisma.pills.findMany({
        //include:{
        //     Doctor: true,
        //     Patient: true,
        // }
    });
    res.status(200).json(reqData);
       
    }catch(error){
        next(error);
    }
})
pillsRoutes.use(auth.test).patch('/pills/:id', async (req, res, next)=>{
    try {
        const data = req.body;
        console.log(data);
        reqData = await prisma.pills.update({data: {
            name: data.name,
            amount: data.amount,
            howLong: data.howLong,
            days: data.days,
            medicineFormMedicalRecordId: Number(data.medicineForm),
            
        }, 
        where: {
            pills: Number(req.params.id)
        }
        //include:{
        //     Doctor: true,
        //     Patient: true,
        // }
    });
        res.status(200).json({reqData, message: 'Pills Updated Successfully'});
       
    }catch(error){
        next(error);
    }
})
pillsRoutes.use(auth.test).delete('/pills/:id', async (req, res, next)=>{
    try {
        
        reqData = await prisma.pills.delete({
            where: {
                pills: Number(req.params.id)
            }
        //include:{
        //     Doctor: true,
        //     Patient: true,
        // }
    });
    res.status(200).json({reqData, message: 'Pills Deleted Successfully'});
       
    }catch(error){
        next(error);
    }
})
module.exports = pillsRoutes;