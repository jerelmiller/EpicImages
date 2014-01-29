angular.module('galleryShow', ['applicationServices', 'applicationDirectives', 'ngResource', 'masonry', 'photoDirectives', 'photoServices', 'photosList'])
.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers['common']['Accept'] = 'application/json'
])
.factory 'Gallery', ($resource) ->
  $resource '/admin/galleries/:id/photos', { id: '@id' },
    photos: { method: 'GET', isArray: true }

.controller 'GalleryShowCtrl', ($scope, $timeout, DataSeed, Gallery, Photo) ->
  DataSeed.then (data) ->
    angular.extend $scope, data

    $scope.addPhotosView.on 'saved', ->
      $scope.fetchingPhotos = true
      Gallery.photos(id: $scope.gallery.id).$promise.then (photos) ->
        $scope.photos = photos
        $scope.fetchingPhotos = false