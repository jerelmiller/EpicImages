angular.module('applicationDirectives', [])
.directive 'spin', ->
  restrict: 'E'
  template: '<div class="spinner"></div>'
  replace: true
  link: (scope, element, attrs) ->
    elementStyles = {}
    defaultStyles =
      top: '50%'
      left: '50%'
      position: 'absolute'

    elementStyles = angular.extend elementStyles, defaultStyles unless angular.isDefined attrs.ignoreDefaults
    elementStyles = angular.extend elementStyles, scope.$eval attrs.spinStyle


    scope.$watch attrs.spinOn, (spin) ->
      spin = spin || false
      if spin then element.spin(left: 'inherit') else element.spin false
      element.css elementStyles
      el = if attrs.dim == 'parent' then element.parent() else angular.element(attrs.dim)
      el.css 'opacity', ''
      el.css 'opacity', '0.3' if spin