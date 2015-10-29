angular.module("Incollage").controller "CollageBuilderCtrl", ($rootScope, $scope, $state,
  Reloader, CollageService) ->

  $scope.init = ->
    $scope.initOptions()
    $scope.initSearcher()
    $scope.initCollageMaker()

  $scope.initOptions = ->
    $scope.options = new Reloader(CollageService.options)
    $scope.options.reload()

  $scope.initSearcher = ->
    $scope.searcher = new Reloader(->
      CollageService.search($scope.getSelectedOptions(8))
    )

  $scope.initCollageMaker = ->
    $scope.collageMaker = new Reloader(->
      CollageService.make($scope.getSelectedOptions(4))
    )

  $scope.getSelectedOptions = (count)->
    res = { 'colors[]': [], 'collections[]': [], count: count }
    for color in $scope.options.data.colors
      res['colors[]'].push color.hex if color.value

    for collection in $scope.options.data.search.collections
      res['collections[]'].push collection.id if collection.value
    res

  $scope.search = ->
    $scope.searcher.reload()

  $scope.make = ->
    $scope.collageMaker.reload()

  $scope.init()
