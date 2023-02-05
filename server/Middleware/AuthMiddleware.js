const jwt = require('jsonwebtoken')

const auth= async (req, res, next) => {
    const authHeader = req.headers.authorization
  
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
        res.status(401).send({ error: 'Please authenticate...' })
    }
  
    const token = authHeader.split(' ')[1]
  
    try {
      const verify = jwt.verify(token, process.env.JWT_SECRET)
      next()
    } catch (error) {
        res.status(401).send({ error: 'Please authenticate...' })
    }
  }

  module.exports = auth