const express = require('express');
const appointRoutes = express.Router();
const auth = require('../middleware/auth')
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient();
// var jwt = require('jsonwebtoken')

appointRoutes.use(auth.test).post('/appointment', async (req, res, next) =>{
    try {
        const data = req.body;
        console.log(data);
        reqData = await prisma.appointment.create({data: {
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
    res.status(200).json({reqData, message: 'Appointment Book Successfully'});
       
    }catch(error){
        next(error);
    }
});


//retrieve appointment 

appointRoutes.use(auth.test).get('/appointment/:id', async (req, res, next)=>{

    try {
        const id = req.params.id;
        console.log(id);
        const data = await prisma.appointment.findMany({
            where:{patientPatientId: Number(id)},
            include: {
                Doctor: true,
                Patient: true
            },
        })
        res.status(200).json({data})
    } catch (error) {
        next(error);
    }
})

appointRoutes.use(auth.test).get('/appointment/doctor/:id', async (req, res, next)=>{

    try {
        const id = req.params.id;
        console.log(id);
        const data = await prisma.appointment.findMany({
            where:{doctorDoctorID: Number(id)},
            include: {
                Doctor: true,
                Patient: true
            },
        })
        res.status(200).json({data})
    } catch (error) {
        next(error);
    }
})

appointRoutes.use(auth.test).patch('/appointment/:id', async (req, res, next)=>{

    try {
        const id = req.params.id;
        console.log(id);
        const data = await prisma.appointment.update({
            data:{
                name: req.body.name,
                time:  new Date(req.body.time),
                Date: new Date(req.body.Date),
                status: req.body.status,
                patientPatientId: Number(req.body.patientPatientId),
                doctorDoctorID: Number(req.body.doctorDoctorID)
            },
            where: {
                appointmentId: Number(id)
            }
        })
        res.status(200).json({data})
    } catch (error) {
        next(error);
    }
})

appointRoutes.use(auth.test).delete('/appointment/:id', async (req, res, next)=>{

    try {
        const id = req.params.id;
        console.log(id);
        const data = await prisma.appointment.delete({
            where: {
                appointmentId: Number(id)
            }
        })
       res.status(200).json({data})
    } catch (error) {
        next(error);
    }
})
module.exports = appointRoutes;