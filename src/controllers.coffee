define [
  "angular"
  "./controllers/DashboardController"
  "./controllers/MainController"
],
(angular, controllers...) ->
  # register module
  module = angular.module("angularseed.controllers", [])

  # register all controllers
  for controller in controllers
    controllerName = controller.$name
    module.controller(controllerName, controller)
