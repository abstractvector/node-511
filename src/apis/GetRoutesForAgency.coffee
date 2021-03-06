AbstractService = require './AbstractService'

class GetRoutesForAgency extends AbstractService

  invoke: (parameters = {}, callback = () ->) =>
    if !parameters.agencyName
      return callback new Error "Call to service #{ @constructor.name } must include parameter agencyName"

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

          routeDirections = []
          for _RD in (_R?.RouteDirectionList?[0]?.RouteDirection ? [])
            if (_RD['$']?.Name)
              routeDirections.push
                Name: _RD['$'].Name
                Code: _RD?['$']?.Code ? null

          if routeDirections.length > 0
            routes[_R['$'].Name].RouteDirections = routeDirections

        agency.Routes = routes

    agency

module.exports = GetRoutesForAgency
