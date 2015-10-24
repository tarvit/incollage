angular.module("Incollage").controller "RootCtrl", ($rootScope, $scope, $state) ->

  $scope.init = ->
    window.Incollage.log 'Incollage Root initialized.'

  $scope.init()


