const jwt = require('jsonwebtoken')
const {PrismaClient} = require('@prisma/client')
const prisma = new PrismaClient()
exports.test = async (req, res, next) => {
    if(req.headers && req.headers.authorization && req.headers.authorization.split(' ')[1]){ 
        const token = req.headers.authorization.split(' ')[1]
        try {
            const decode = await jwt.verify(token, "fake-jwt-secret") 
            console.log(decode);
            const user = await prisma.user.findFirst({where:{userId: decode.userId}})
            if(!user){
                res.status(401).json({message: 'UnAuthorized '})
                return;
            }
            next()
        } catch (error) {
            // console.log(error)
            res.status(401).send("Unauthorize")
            
        }
    }
   return;

}