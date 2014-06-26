request = require 'request'
xml2js = require 'xml2js'

class AbstractService

  @userAgent = "node-511 API wrapper for node.js - https://github.com/abstractvector/node-511"

  constructor: (url) ->
    @url = url ? throw new Error 'No URL provided for endpoint'

  invoke: (parameters = {}, callback = () ->) =>
    self = @
    @._request @url, parameters, (err, response, body) ->
      return callback err if err
      xml2js.parseString body, (err, result) ->
        return callback err if err
        callback null, self._parse result, body, response

  _request: (url, parameters, callback) ->
    request {url: url, qs: parameters, headers: {"User-Agent": @userAgent}}, callback

  _parse: (obj) ->
    {}

module.exports = AbstractService
