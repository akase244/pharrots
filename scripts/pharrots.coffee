request = require 'request'
cheerio = require 'cheerio'

module.exports = (robot) ->
    robot.respond /(cur|old)/i, (msg) ->
        msg.send msg.match[1]
        msg.send msg.match[2]

        options =
          url: 'http://php.net/downloads.php'
          timeout: 2000
          headers: {'user-agent': 'php version fetcher'}

        request options, (error, response, body) ->

            $ = cheerio.load body

            $('.release-state').each ->
                releaseState = $ @
                if msg.match[1] and releaseState.text() is 'Current Stable'
                    msg.send releaseState.parent().attr('id').replace(/v/, '')
