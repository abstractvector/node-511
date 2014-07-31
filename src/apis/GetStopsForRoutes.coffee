AbstractService = require './AbstractService'

class GetStopsForRoutes extends AbstractService

  invoke: (parameters = {}, callback = () ->) =>
    if !parameters.route && !parameters.routeIDF
      return callback new Error "Call to service #{ @constructor.name } must include parameter route or routeIDF"

    if parameters.routeIDF && Array.isArray parameters.routeIDF
      parameters.routeIDF = parameters.routeIDF.join '|'


    if !Array.isArray parameters.route
      return callback new Error "Call to service #{ @constructor.name } included parameter route as type #{ typeof parameters.route } when it should be an array"

    if parameters.route
      routeIDFs = []

      for r in parameters.route
        routeIDF = []
        if r.agencyName
          routeIDF.push r.agencyName

        if r.routeCode
          routeIDF.push r.routeCode

        if r.routeDirectionCode
          routeIDF.push r.routeDirectionCode

        routeIDFs.push routeIDF.join '~'

      parameters.routeIDF = routeIDFs.join '|'
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
                StopCode: _S['$']?.StopCode ? null

          routes[_R['$'].Name].Stops = stops

        agency.Routes = routes

    agency

module.exports = GetStopsForRoutes
