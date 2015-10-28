angular.module("Incollage").controller "CollageBuilderCtrl", ($rootScope, $scope, $state,
  Reloader, CollageService) ->

  $scope.init = ->
    $scope.initOptions()

  $scope.initOptions = ->
    $rootScope.stats.promise.then((resp)->
      $scope.initPicturesOptions(resp)
    )

  $scope.initPicturesOptions = (stats)->
   stats

  $scope.init()
