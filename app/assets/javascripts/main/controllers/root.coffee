angular.module("Incollage").controller "RootCtrl", ($rootScope, $scope, $state, $mdSidenav, $mdMedia,
  StatsService, Reloader) ->

  $scope.init = ->
    window.Incollage.log 'Incollage Root initialized.'
    $rootScope.state = $state
    $scope.reloadStats()

  $scope.reloadStats = ->
    $rootScope.stats = new Reloader(StatsService.query)
    $rootScope.stats.reload()

  $scope.init()
