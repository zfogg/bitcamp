directives = angular.module 'bitcamp.directives', []

directives.directive 'appVersion', ['version', (version) ->
  (scope, elm, attrs) ->
    elm.text version
]
