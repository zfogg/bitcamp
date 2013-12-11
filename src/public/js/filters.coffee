filters = angular.module 'bitcamp.filters', []

filters.filter 'interpolate', ['version', (version) ->
  (text) ->
    String(text).replace /\%VERSION\%/mg, version
]
