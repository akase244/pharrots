request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
    robot.respond /(cur|old)/i, (msg) ->
        options =
          url: 'http://php.net/downloads.php'
          timeout: 2000
          headers: {'user-agent': 'php version fetcher'}

        request options, (error, response, body) ->

            $ = cheerio.load body

            $('.release-state').each ->
                releaseState = $ @
                msg.send '0'
                if msg.match[2].toLowerCase() is 'old'
                    msg.send '1'
                    msg.send msg.match[2].toLowerCase()
                msg.send '2'
                if releaseState.text() is 'Old Stable'
                    msg.send '3'
                    msg.send releaseState.text()
                msg.send '4'
                if msg.match[1].toLowerCase() is 'cur' and releaseState.text() is 'Current Stable'
                    msg.send '5'
                    msg.send releaseState.parent().attr('id').replace(/v/, '')
                msg.send '6'
                #if msg.match[2].toLowerCase() is 'old' and releaseState.text() is 'Old Stable'
                #    msg.send '7'
                #    msg.send releaseState.parent().attr('id').replace(/v/, '')

