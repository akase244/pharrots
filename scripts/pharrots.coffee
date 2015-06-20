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
                if msg.match[1].toLowerCase() is 'cur'
                    msg.send releaseState.parent().attr('id').replace(/v/, '')
                if releaseState.text() is 'Current Stable'
                    msg.send releaseState.parent().attr('id').replace(/v/, '')
                if msg.match[1].toLowerCase() is 'cur' and releaseState.text() is 'Current Stable'
                    msg.send releaseState.parent().attr('id').replace(/v/, '')
                #if msg.match[2].toLowerCase() is 'old' and releaseState.text() is 'Old Stable'
                    #msg.send releaseState.parent().attr('id').replace(/v/, '')
