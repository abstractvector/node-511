AbstractService = require './AbstractService'

class GetStopsForRoute extends AbstractService

  invoke: (parameters = {}, callback = () ->) =>
    if !parameters.route && !parameters.routeIDF
      return callback new Error "Call to service #{ @constructor.name } must include parameter route or routeIDF"

    if parameters.route
      params = []

      if parameters.route.agencyName
        params.push parameters.route.agencyName

      if parameters.route.routeCode
        params.push parameters.route.routeCode

      if parameters.route.routeDirectionCode
        params.push parameters.route.routeDirectionCode

      parameters.routeIDF = params.join '~'
      delete parameters.route

    super parameters, callback

  _parse: (obj) ->
    for _A in obj?.RTT?.AgencyList?[0]?.Agency ? []
      if (_A?['$']?.Name)
        name =_A?['$']?.Name
        agency =
          HasDirection: 'True' == _A?['$']?.HasDirection
          Mode: _A?['$']?.Mode ? null

        routes = {}
        for _R in (_A?.RouteList?[0]?.Route ? [])
          if (_R?['$']?.Name)
            routes[_R['$'].Name] = 
              Code: _R?['$']?.Code ? null

          stops = []
          for _S in (_R?.StopList[0]?.Stop ? [])
            if (_S['$']?.name)
              stops.push
                Name: _S['$'].name
                Code: _S['$']?.StopCode ? null

          routes[_R['$'].Name].Stops = stops

        agency.Routes = routes

    agency

module.exports = GetStopsForRoute
