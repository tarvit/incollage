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
      @promise = @load()
      @promise.$promise.then((response)=>
        @data = response
        @loading = false
        @loaded = true
      )

    data: -> @data
    loaded: -> @loaded
