define [], () ->
  class EventService
    @$inject = ["$http"]

    constructor: (@http) ->
      @listeners = {}
      @nextListenerId = 1
      @pushClientId = null

      @registerDomEvents()

    listen: (namespace, name, args...) =>
      fqen = "#{namespace}:#{name}";

      # make sure that the listeners list is not null
      if not this.listeners[fqen]
        @listeners[fqen] = []

      # get new unique listener id
      listenerId = @nextListenerId++

      callback = null
      scope = null

      # search arguments for callback and scope
      for arg in args
        if not callback? and typeof arg == "function" then callback = arg
        if not scope? and typeof arg == "object" and arg?.$on? then scope = arg

      # if there is a callback then add it to listeners
      if callback?
        @listeners[fqen].push({ id: listenerId, callback: callback })
      # if there is a scope then register unlistening on scope destruction
      if scope?
        scope.$on "$destroy", () => @unlisten(listenerId)

      # return listener id
      listenerId

    unlisten: (listenerId) =>
      # search all namespaces and all listeners for id and remove it if found
      for fqen, listeners of @listeners
        for listener, i in listeners
          if listener.id == listenerId
            listeners.splice i, 1
            return true
      false

    emit: (namespace, name, data) =>
      fqen = "#{namespace}:#{name}"
      fqenMulti = "#{namespace}:*"

      # TODO: remove
      console.log fqen, data if name.substr(0,4) != 'tick'

      listeners = @listeners[fqen] ? []
      for listener in listeners
        listener.callback(data)
      listeners = @listeners[fqenMulti] ? []
      for listener in listeners
        listener.callback(data)

    registerDomEvents: () =>
      $(window).resize((event) => @emit("global", "resize", event))
      $(window).keydown((event) => @emit("global", "keydown", event))
      $(window).keypress((event) => @emit("global", "keypress", event))
      $(window).keyup((event) => @emit("global", "keyup", event))

      @globalTick(100)
      @globalTick(1000)
      @globalTick(5000)
      @globalTick(10000)

    globalTick: (frequence) =>
      @emit("global", "tick#{frequence}", null);
      window.setTimeout (() =>
        @globalTick(frequence)), frequence
