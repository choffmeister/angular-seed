requirejs.config
  baseUrl: "/src"
  paths:
    jquery: "../bower_components/jquery/jquery"
    underscore: "../bower_components/underscore/underscore"
    bootstrap: "../bower_components/bootstrap/dist/js/bootstrap"
    angular: "../bower_components/angular/angular"
    basecontroller: "./controllers/BaseController"

  shim:
    underscore:
      exports: "_"
    bootstrap:
      deps: ["jquery"]
    angular:
      exports: "angular"
      deps: ["jquery"]

requirejs [
  "angular"
  "./services/ApiService"
  "./services/EventService"
  "./controllers"
  "./routes"
  "./misc"
],
(angular, ApiService, EventService) ->
  # services
  angular.module("angularseed.services", [])
    .factory("api", ["$http", "$q", "events", (http, q, events) => new ApiService(http, q, events)])
    .factory("events", ["$http", (http) -> new EventService(http)])

  # compose
  angular.module "angularseed", [
    "angularseed.services"
    "angularseed.controllers"
    "angularseed.routes"
    "myfilters"
    "mydirectives"
  ]

  # bootstrap
  angular.element(document).ready () -> angular.bootstrap document, ["angularseed"]
