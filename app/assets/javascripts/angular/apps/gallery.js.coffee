angular.module('gallery', ['applicationServices', 'photosList', 'masonry'])
.controller 'GalleryCtrl', ($scope, DataSeed) ->
  DataSeed.then (data) ->
    angular.extend $scope, data