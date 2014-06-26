Client = require './src/client'

client = new Client
  token: '4ccce8f3-d7cc-4268-9de8-5de08a6fb7e7'

client.GetRoutesForAgencies (err, result) ->
  console.log JSON.stringify(result)
, {agencyNames: ['BART', 'SF-MUNI']}
