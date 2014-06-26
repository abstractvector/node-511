AbstractService = require './AbstractService'

class GetAgencies extends AbstractService

  _parse: (obj) ->
    agencies = {}

    for _A in obj?.RTT?.AgencyList?[0]?.Agency ? []
      if (_A?['$']?.Name)
        agencies[_A?['$']?.Name] =
          HasDirection: 'True' == _A?['$']?.HasDirection
          Mode: _A?['$']?.Mode ? null

    agencies

module.exports = GetAgencies
