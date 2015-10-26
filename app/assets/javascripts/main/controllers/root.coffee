angular.module("Incollage").controller "RootCtrl", ($rootScope, $scope, $state, $mdSidenav, $mdMedia
  StatsService) ->

  $scope.init = ->
    window.Incollage.log 'Incollage Root initialized.'
    $rootScope.state = $state
    $scope.reloadStats()

  $scope.reloadStats = ->
    $scope.stats = StatsService.query()

  $scope.init()
