const fs = require('fs')

class ProcessUsageWatcher {
    constructor() {
        global.pubcrawler = global.pubcrawler || {}
        global.pubcrawler.processCpuUsage = 0
    }

    startWatching() {
        if (this.interval) {
            return
        }

        const getUsage = cb => {
            fs.readFile('/proc/' + process.pid + '/stat', (err, data) => {
                const elems = data.toString().split(' ')
                const utime = parseInt(elems[13])
                const stime = parseInt(elems[14])

                cb(utime + stime)
            })
        }

        this.interval = setInterval(() => {
            getUsage((startTime) => {
                setTimeout(() => {
                    getUsage((endTime) => {
                        const delta = endTime - startTime
                        const percentage = 100 * (delta / 500)

                        global.processCpuUsage = percentage
                    })
                }, 5000)
            })
        }, 1000)
    }

    stopWatching() {
        if (this.interval) {
            clearInterval(this.interval)
        }
    }
}

const instance = new ProcessUsageWatcher()

exports.startWatching = instance.startWatching
exports.stopWatching = instance.stopWatching
