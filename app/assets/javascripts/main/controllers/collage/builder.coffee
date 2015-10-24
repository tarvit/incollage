angular.module("Incollage").controller "CollageBuilderCtrl", ($rootScope, $scope, $state) ->

  $scope.init = ->
    window.Incollage.log 'Builder initialized.'

  $scope.init()
