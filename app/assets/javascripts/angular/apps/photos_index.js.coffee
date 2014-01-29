angular.module('photosIndex', ['applicationServices', 'applicationDirectives', 'masonry', 'ngResource', 'photosList'])
.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers['common']['Accept'] = 'application/json'
])

.controller 'PhotoListCtrl', ($scope, $timeout, DataSeed, Photo) ->
  DataSeed.then (data) ->
    angular.extend $scope, data

    # angular.forEach $scope.photos, (photo) ->
    #   photo.fetchingImage = true
    #   $timeout ->
    #     Photo.fetchImageUrl(id: photo.id).$promise.then (response) ->
    #       photo.thumb = response.thumb
    #       photo.fetchingImage = false
    #       photo.retrievedImage = true