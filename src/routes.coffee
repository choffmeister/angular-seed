define ["angular"], (angular) ->
  angular.module("angularseed.routes", [])
    .config ["$routeProvider", "$locationProvider", (routeProvider, locationProvider) ->
      routeProvider
        .when("/", { redirectTo: "/dashboard" })
        .when("/dashboard", { templateUrl: "/views/dashboard.html", controller: "DashboardController" })
        .otherwise({ templateUrl: "/views/notfound.html" })

      locationProvider.html5Mode(true)
    ]
