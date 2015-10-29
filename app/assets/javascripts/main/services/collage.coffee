angular.module("Incollage").factory "CollageService", ($resource) ->

  $resource "/api/v1/collage/options", { count: '@count', colors: '@colors', collections: '@collections' },
    options:
      method: 'GET'

    search:
      url: "/api/v1/collage/search"
      method: 'GET'
