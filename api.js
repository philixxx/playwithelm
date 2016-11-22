var jsonServer = require('json-server')
var server = jsonServer.create()
var router = jsonServer.router('full.json')
var middlewares = jsonServer.defaults()

// Set default middlewares (logger, static, cors and no-cache)
server.use(middlewares)

// Add custom routes before JSON Server router
server.get('/api/block/:id', function (req, res) {
  console.log("bla" ,req.params.id)
    res.json({Id: req.params.id, SectorName: "C", SectorIndex: 1, Status : "BLOCKED"})

})
server.post('/api/pricequote', function (req, res) {

    res.json({quotation: 10})

})
server.use(jsonServer.bodyParser)
server.use(function (req, res, next) {

  if (req.method === 'POST') {
    req.body.createdAt = Date.now()
    

  }
  // Continue to JSON Server router
  next()
})

// Use default router
server.use(router)
server.listen(5000, function () {
  console.log('JSON Server is running')
})
