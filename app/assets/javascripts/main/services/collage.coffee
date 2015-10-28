angular.module("Incollage").factory "CollageService", ($resource) ->

  $resource "/api/v1/collage/options", { },
    options:
      method: 'GET'

