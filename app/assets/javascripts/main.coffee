#= require turbolinks

#= require jquery
#= require bootstrap

#= require angular
#= require angular-route
#= require angular-ui-router
#= require angular-resource
#= require angular-animate
#= require angular-aria
#= require angular-material
#= require lodash
#= require angular-bootstrap
#= require angular-rails-templates

#= require ngtimeago
#= require angular-cookies

#= require_tree ../templates
#= require_tree ./app

window.Incollage =
  debug: true
  log: (message)->
    return unless window.Incollage.debug
    console.log(message)
