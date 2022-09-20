const router = require('express').Router();
// const {PrismaClient}= require('@prisma/client')
// const prisma = new PrismaClient()
// router.get('/products', async (req, res, next) => {
//   try {
//       const products = await prisma.product.findMany({
//         // include: { category: true},
//         include: { Category: true,}
//       })

//       const category = await prisma.category.findMany({
//         include: {products: true}
//       })
//       res.json({products,category})
//     }catch(err) {
//       next(err)
//     }
// }); 

// router.get('/products/:id', async (req, res, next) => {
//  try {
//   const id = req.params.id;
//   const product = await prisma.product.findUnique({where: {id: Number(id),}})
//   res.json({product})
//  } catch (error) {
//     next(error)
//  }
// }); 
// router.post('/products', async (req, res, next) => {
//   try {
//     const data = req.body;
//     const product = await prisma.product.create({
//       data: req.body
//     })
//     res.json(product)
//   } catch (err) {
//     next(err)
//   }
// }); 
// router.delete('/products/:id', async (req, res, next) => {
//   try {
//     const id = req.params.id;
//     const deleteProduct = await prisma.product.delete({where: {id: Number(id),}})
//     res.json({deleteProduct})
//    } catch (error) {
//       next(error)
//    }
// });  
// router.patch('/products/:id', async (req, res, next) => {
//   try {
//     const {id} = req.params
//     const product = await prisma.product.update({where: {id: Number(id)},data: req.body, include: {Category: true}})

//     res.json({product})
//    } catch (error) {
//       next(error)
//    }
// }); 
const userRouter = require('./api.user')
const authRoutes = require('./api.auth')
const reminderRoutes = require('./api.reminder')
const pillsRoutes = require('./api.pills')
const medicationRoutes = require('./api.medication')
const appointRouter = require('./api.appointment');
router.use(userRouter)
router.use(authRoutes)
router.use(reminderRoutes)
router.use(medicationRoutes)
router.use(pillsRoutes)
router.use(appointRouter);

module.exports = router;
