window.Incollage =
  debug: true
  log: (message)->
    return unless window.Incollage.debug
    console.log(message)
