bitcamp = angular.module 'bitcamp', [
  'ngRoute'
  'bitcamp.filters'
  'bitcamp.services'
  'bitcamp.directives'
  'bitcamp.controllers'
]

bitcamp.config ['$routeProvider']

console.log 'This one time, at bitcamp . . .'
