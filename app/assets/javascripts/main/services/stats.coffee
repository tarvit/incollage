angular.module("Incollage").factory "StatsService", ($resource) ->

  $resource "/api/v1/stats", { },
    query:
      method: 'GET'

