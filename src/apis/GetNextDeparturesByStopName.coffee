AbstractService = require './AbstractService'

class GetNextDeparturesByStopName extends AbstractService

  invoke: (parameters = {}, callback = () ->) =>
    if !parameters.agencyName
      return callback new Error "Call to service #{ @constructor.name } must include parameter agencyName"

    if !parameters.stopName
      return callback new Error "Call to service #{ @constructor.name } must include parameter stopName"

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
          for _S in (_R?.StopList?[0]?.Stop ? [])
            if (_S['$']?.name)
              departureTimes = []
              for _DT in (_S?.DepartureTimeList?[0]?.DepartureTime ? [])
                departureTimes.push _DT

              stops.push
                Name: _S['$'].name
                StopCode: _S?['$']?.StopCode ? null
                DepartureTimes: departureTimes

          routes[_R['$'].Name].Stops = stops

        agency.Routes = routes

    agency

module.exports = GetNextDeparturesByStopName
