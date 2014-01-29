angular.module('photosIndex', ['applicationServices', 'applicationDirectives', 'masonry', 'ngResource', 'photosList'])
.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers['common']['Accept'] = 'application/json'
])

.controller 'PhotoListCtrl', ($scope, $timeout, DataSeed, Photo) ->
  DataSeed.then (data) ->
    angular.extend $scope, data

    $scope.addPhotosView.on 'saved', ->
      $scope.fetchingPhotos = true
      Photo.query().$promise.then (photos) ->
        $scope.photos = photos
        $scope.fetchingPhotos = false

  $scope.currentTab = 'photos'
  $scope.switchTab = (tab) -> $scope.currentTab = tab
  $scope.tabIsSelected = (tab) -> $scope.currentTab == tab