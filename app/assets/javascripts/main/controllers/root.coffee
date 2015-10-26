angular.module("Incollage").controller "RootCtrl", ($rootScope, $scope, $state, $mdSidenav, $mdMedia,
  StatsService, Reloader) ->

  $scope.init = ->
    window.Incollage.log 'Incollage Root initialized.'
    $rootScope.state = $state
    $scope.reloadStats()

  $scope.reloadStats = ->
    $scope.stats = new Reloader(->StatsService.query())
    $scope.stats.reload()

  $scope.init()
