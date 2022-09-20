const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()
const bcrypt = require('bcrypt');
const saltRounds = 10;

exports.createUser = async (req, res, next) => {
    try {
        console.log(req.body);
        const password = await bcrypt.hash(req.body.password, saltRounds)
       const data = await prisma.user.create({
        data: {
            name: req.body.name,
            surname: req.body.surname,
            email: req.body.email,
            password: password,
            telephone: req.body.telephone,
            country: req.body.country,
            status: Boolean(req.body.status)
        }
       })
      const ca = await prisma.patient.create({
        data:{
            bloodGroup: req.body.bloodGroup,
            userID: data.userId
        }
      })
       res.status(201).json({message: "user register successfully"})
    } catch (error) {
        next(error)
    }
}
exports.createDoctor = async (req, res, next) => {

    try {
        console.log(req.body);
        const password = await bcrypt.hash(req.body.password, saltRounds)
       const data = await prisma.user.create({
        data: {
            name: req.body.name,
            surname: req.body.surname,
            email: req.body.email,
            password: password,
            telephone: req.body.telephone,
            country: req.body.country,
            status: req.body.status
        }
       })
      const ca = await prisma.doctor.create({
        data:{
            studies: req.body.studies,
            practicing: req.body.practicing,
            departmentDeptId: req.body.departmentDeptId,
            userUserId: data.userId
        }
      })
       res.json({data, ca})
    } catch (error) {
        next(error)
    }
}
exports.getUser = async (req, res, next) => {
   try {
    const id = req.params.id

    const data = await prisma.user.findUnique({
        where: {
            userId: Number(id)
        }
    })
    res.json(data)
   } catch (error) {
    next(error)
   }

}
exports.delete = async (req, res, next) => {
    try {
        const id = req.params.id
        const data = await prisma.user.delete({where:{userId: Number(id)}})
        res.json(data)
    } catch (error) {
        next(error)
    }
}