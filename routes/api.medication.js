const express = require('express');
const MedicationRoutes = express.Router();
const auth = require('../middleware/auth')
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();


MedicationRoutes.use(auth.test).post('/medication', async (req, res, next)=>{
    try {
        const data = req.body;
        console.log(data);
        reqData = await prisma.medication.create({data: {
            name: data.name,
            time:  new Date(data.time),
            Date: new Date(data.Date),
            status: data.status,
            patientPatientId: Number(data.patientPatientId),
            doctorDoctorID: Number(data.doctorDoctorID)
        }, 
        //include:{
        //     Doctor: true,
        //     Patient: true,
        // }
    });
        res.json({reqData, message: 'Appointment Book Successfully'});
       
    }catch(error){
        next(error);
    }
})

module.exports = MedicationRoutes;