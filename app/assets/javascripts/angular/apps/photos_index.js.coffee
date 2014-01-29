angular.module('photosIndex', ['applicationServices', 'applicationDirectives', 'masonry', 'ngResource', 'photosList'])
.config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers['common']['Accept'] = 'application/json'
])

.controller 'PhotoListCtrl', ($scope, $timeout, DataSeed, Photo) ->
  DataSeed.then (data) ->
    angular.extend $scope, data

  $scope.currentTab = 'photos'
  $scope.switchTab = (tab) -> $scope.currentTab = tab
  $scope.tabIsSelected = (tab) -> $scope.currentTab == tab