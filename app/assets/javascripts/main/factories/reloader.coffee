angular.module("Incollage").factory "Reloader", ->
  class Reloadable
    constructor: (@load)->
      @data = null
      @promise = null
      @loaded = false
      @loading = false

    reload: =>
      return if @loading
      @loading = true
      @request = @load()
      @promise = @request.$promise
      @promise.then(@onSuccess, @onError)

    onError: (reason)=>
      @error = reason
      @loading = false

    onSuccess: (response)=>
      @data = response
      @error = null
      @loading = false
      @loaded = true

