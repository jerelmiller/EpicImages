angular.module('galleryShow', ['applicationServices', 'applicationDirectives', 'ngResource'])
.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers['common']['Accept'] = 'application/json'
])

.directive 'masonry', ($timeout) ->
  (scope, element, attrs) ->
    scope.$on 'triggerMasonry', -> $timeout (-> element.masonry()), 1

.directive 'triggerMasonry', ->
  (scope, element, attrs) ->
    element.parent().masonry 'appended', element
    scope.$root.$broadcast 'triggerMasonry'

.directive 'photo', ($timeout) ->
  restrict: 'C'
  link: (scope, element, attrs) ->
    $timeout (-> element.spin()), 1
    element.imagesLoaded ($image) ->
      element.spin false
      $image.fadeIn()

.factory 'Photo', ($resource) ->
  $resource '/admin/galleries/:id/photos', { id: '@id' },
    fetchAll: { method: 'GET', isArray: true }

.controller 'GalleryShowCtrl', ($scope, DataSeed, Photo) ->
  DataSeed.then (data) ->
    angular.extend $scope, data

    $scope.addPhotosView.on 'saved', ->
      $scope.fetchingPhotos = true
      Photo.fetchAll(id: $scope.gallery.id).$promise.then (photos) ->
        $scope.photos = photos
        $scope.fetchingPhotos = false