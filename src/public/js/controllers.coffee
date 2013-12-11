controllers = angular.module 'bitcamp.controllers', []


controllers.controller 'BitcampCtrl', [
  "$scope", ($scope) ->
    $scope.a = 1
    $scope.b = 1
]


controllers.controller 'HeaderCtrl', [
  "$scope", ($scope) ->
]

controllers.controller 'ContentCtrl', [
  "$scope", ($scope) ->
]

controllers.controller 'FooterCtrl', [
  "$scope", ($scope) ->
]


controllers.controller 'HomeCtrl', [
  "$scope", ($scope)->
]
