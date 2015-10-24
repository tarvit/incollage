#= require_self
#
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
  'Incollage.components'
]

