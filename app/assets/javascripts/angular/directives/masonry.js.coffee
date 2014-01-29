angular.module('masonry', [])
.directive 'masonry', ($timeout) ->
  (scope, element, attrs) ->
    scope.$on 'triggerMasonry', -> $timeout (-> element.masonry()), 1

.directive 'triggerMasonry', ->
  (scope, element, attrs) ->
    element.parent().masonry 'appended', element
    scope.$root.$broadcast 'triggerMasonry'