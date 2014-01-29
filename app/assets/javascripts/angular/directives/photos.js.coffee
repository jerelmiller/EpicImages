angular.module('photoDirectives', [])
.directive 'imagesLoaded', ($parse) ->
  restrict: 'A'
  link: (scope, element, attrs) ->
    triggerLoadingAttr = $parse(attrs.imagesLoaded)

    triggerImagesLoaded = ->
      element.spin()

      element.imagesLoaded ($image) ->
        element.spin false
        $image.fadeIn()

    triggerImagesLoaded() if triggerLoadingAttr(scope)
    scope.$watch triggerLoadingAttr, (shouldTrigger) -> triggerImagesLoaded() if shouldTrigger