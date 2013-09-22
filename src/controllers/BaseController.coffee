define ["underscore", "angular"], (_, angular) ->
  class BaseController
    @$inject = ["$scope", "$routeParams", "$location", "api", "events"]

    constructor: (@scope, @params, @location, @api, @events) ->
      @listenerIds = []
      @updateThrottled = _.throttle(@update, 1000)
      @scope.params = @params
      @scope.$on "$destroy", () =>
        @unlisten()
        @dispose()
      @init()

    init: () =>
      # do nothing

    dispose: () =>
      # do nothing

    update: () =>
      # do nothing

    emitMessage: (type, text) =>
      @events.emit "message", type,
        type: type
        text: text

    listen: (namespace, name, callback) =>
      @listenerIds.push(@events.listen(namespace, name, callback))

    unlisten: () =>
      for listenerId in @listenerIds
        @events.unlisten(listenerId)
