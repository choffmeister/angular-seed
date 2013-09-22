define ["basecontroller"], (BaseController) ->
  class DashboardController extends BaseController
    @$name = "DashboardController"

    init: () =>
      @scope.name = "Angular Seed"
