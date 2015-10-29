angular.module("Incollage").controller "CollageBuilderCtrl", ($rootScope, $scope, $state,
  Reloader, CollageService) ->

  $scope.init = ->
    $scope.initOptions()

  $scope.initOptions = ->
    $scope.options = new Reloader(CollageService.options)
    $scope.options.reload()

  $scope.init()
