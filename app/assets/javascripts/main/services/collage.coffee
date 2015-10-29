angular.module("Incollage").factory "CollageService", ($resource) ->

  params = { count: '@count', colors: '@colors', collections: '@collections', url: '@urls' }
  $resource "/api/v1/collage/options", params,
    options:
      method: 'GET'

    search:
      url: "/api/v1/collage/search"
      method: 'GET'

    make:
      url: "/api/v1/collage/make"
      method: 'GET'
