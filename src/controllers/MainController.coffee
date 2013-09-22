define ["basecontroller"], (BaseController) ->
  class MainController extends BaseController
    @$name = "MainController"

    init: () =>
      @scope.messages = []
      @scope.dismissMessage = @dismissMessage

      @listen "message", "*", @onMessage

    onMessage: (data) =>
      @scope.messages.push(data)

    dismissMessage: (messageToDismiss) =>
      for message, i in @scope.messages
        if message == messageToDismiss
          @scope.messages.splice i, 1
