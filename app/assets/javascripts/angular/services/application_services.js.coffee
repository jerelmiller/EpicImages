angular.module('applicationServices', [])
.factory 'DataSeed', ($q, $window, $rootScope) ->
  deferred = $q.defer()
  $window.EpicImages.AngularDataSeed = (obj) ->
    deferred.resolve(obj)
    $rootScope.$apply()
  deferred.promise