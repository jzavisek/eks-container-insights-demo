const express = require('express')
const os = require('os')
const path = require('path')
const fs = require('fs')
const util = require('util')

const PORT = 3000
const hostname = os.hostname()
const serverStart = new Date().toISOString()

const readFileAsync = util.promisify(fs.readFile)
const asyncRoute = (route) => (req, res, next) =>
  Promise.resolve(route(req, res)).catch(next)

const app = express()

app.get('/api', (req, res) => res.json({ hostname, app: 'api' }))
app.get('/api/health-check', (req, res) =>
  res.json({ message: 'I am healthy 💊', app: 'api' }),
)

app.get(
  '/',
  asyncRoute(async (req, res) => {
    const indexPage = await readFileAsync(
      path.join(__dirname, './index.html'),
      'utf8',
    )
    res.type('text/html')
    res.send(indexPage.replace('$SERVER_START$', serverStart))
  }),
)

app.listen(PORT, () =>
  console.log(`Example app listening on port ${PORT}! Host: ${hostname}`),
)
