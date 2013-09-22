define ["angular"], (angular) ->
  # filters
  angular.module("myfilters", [])
    .filter "loremipsumTiny", () ->
      (text) -> "#{text}: Lorem ipsum dolor sit amet, consetetur sadipscing elitr."
    .filter "loremipsumShort", () ->
      (text) -> "#{text}: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua."
    .filter "loremipsum", () ->
      (text) -> "#{text}: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."

  # sdirective
  angular.module("mydirectives", [])
    .directive "goto", ["$location", (location) -> {
      replace: false
      link: (scope, element, attrs) ->
        element.css "cursor", "pointer"
        element.click () ->
          scope.$apply () -> location.path(attrs.goto)
    }]
