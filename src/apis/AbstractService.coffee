request = require 'request'
xml2js = require 'xml2js'

class AbstractService

  constructor: (url) ->
    @url = url ? throw new Error 'No URL provided for endpoint'

    @timeout = 5000

    @userAgent = "node-511 API wrapper for node.js - https://github.com/abstractvector/node-511"

  invoke: (parameters = {}, callback = () ->) =>
    self = @
    service = @constructor.name

    @._request @url, parameters, (err, response, body) ->

      if err?.code is 'ETIMEDOUT'
        return callback new Error "Call timed out after #{ self.timeout }ms when calling #{ service }"

      xml2js.parseString body, (err, result) ->
        return callback new Error "Error when parsing XML response for #{ service }: #{ err.message }" if err
        callback null, self._parse result, body, response

  _request: (url, parameters, callback) ->
    request {url: url, qs: parameters, headers: {"User-Agent": @userAgent}, timeout: @timeout}, callback

  _parse: (obj) ->
    {}

module.exports = AbstractService
