const express = require('express')
const app = express()
const os = require('os')

require('./watcher').startWatching();

let shouldRun = false

const blockCpuFor = ms => {
    const now = new Date().getTime()
    let result = 0
    shouldRun = true

    while (shouldRun) {
        result += Math.random() * Math.random()

        if (new Date().getTime() > now + ms) {
            shouldRun = false

            return
        }
    }
}

setInterval(() => {
    console.log('Current CPU usage: ' + (global.processCpuUsage || 0) + '%')
}, 500);

app.get('/', (req, res) => res.send({
    version: process.env.SHATTERDOME_APP_VERSION,
    hostname: os.hostname(),
}))

app.get('/load/:interval?', (req, res) => {
    const interval = (req.params.interval || 20) * 1000

    blockCpuFor(interval)

    res.sendStatus(200).end()
})

app.get('/health/live', (req, res) => {
    if (process.uptime() < 600) {
        res.sendStatus(200).end()
    }

    res.sendStatus(500).end()
})

app.get('/health/ready', (req, res) => {
    if (process.uptime() > 15) {
        res.sendStatus(200).end()
    }

    res.sendStatus(500).end()
})

app.get('/health/uptime', (req, res) => res.send({
    uptime: process.uptime()
}))

app.listen(3000, () => console.log('Server listening on port 3000'))
