url = require 'url'

class Client

  @tokenRegistrationURL: 'http://511.org/developer-resources_api-security-token_rtt.asp'

  constructor: (options = {}) ->
    @token = options.token ? throw new Error "No token specified - please see: #{ Client.tokenRegistrationURL }"

    @host = options.host ? 'http://services.my511.org'

    @paths =
      GetAgencies: '/Transit2.0/GetAgencies.aspx'
      GetRoutesForAgencies: '/Transit2.0/GetRoutesForAgencies.aspx'
      GetRoutesForAgency: '/Transit2.0/GetRoutesForAgency.aspx'
      GetStopsForRoute: '/Transit2.0/GetStopsForRoute.aspx'
      GetStopsForRoutes: '/Transit2.0/GetStopsForRoutes.aspx'
      GetNextDeparturesByStopName: '/Transit2.0/GetNextDeparturesByStopName.aspx'

    @services = []

    for service, path of @paths
      try
        urlObj = url.parse @host
        urlObj.pathname = path

        _service = new (require "./apis/#{ service }") url.format urlObj

        bindInvoke = (s) ->
          (callback, options = {}) ->
            callback ?= () ->
            options.token = @token
            s.invoke options, callback

        this[service] = bindInvoke _service
      catch error
        console.warn "Error loading service: #{ service }"
        this[service] = (callback = () ->) ->
          callback new Error "Service #{ service } was not loaded correctly"
          

module.exports = Client
