#= require_self
#= require_tree ./services
#= require_tree ./factories
#= require_tree ./controllers
#= require_tree ./directives

App = angular.module 'Incollage', [
  'ngResource'
  'ngRoute'
  'ui.router'
  'ui.bootstrap'
  'ngtimeago'
  'ngCookies'
  'ngMaterial'
  'templates'
  'Incollage.components'
]

App.config ($urlRouterProvider, $stateProvider) ->
  $urlRouterProvider.otherwise("/state/collage/builder")
  $stateProvider.state("collage_builder",
    url: "/state/collage/builder"
    views:
      content:
        templateUrl: "collage/builder.html"
        controller: 'CollageBuilderCtrl'
  )

