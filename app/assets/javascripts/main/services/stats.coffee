angular.module("Incollage").factory "StatsService", ($resource) ->

  $resource "/api/stats", { },
    query:
      method: 'GET'

