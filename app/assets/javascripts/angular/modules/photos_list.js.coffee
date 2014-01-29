angular.module('photosList', ['photoServices', 'photoDirectives', 'applicationDirectives'])
.directive 'photosList', ($parse, $timeout, Photo) ->
  restrict: 'E'
  template: JST['angular/templates/photos/photos_list']()
  replace: true
  scope:
    photos: '='
    canEdit: '='
  link: (scope, element, attrs) ->
    fetchPhoto = (photo) ->
      $timeout ->
        unless photo.thumb
          photo.fetchingImage = true
          Photo.fetchImageUrl(id: photo.id).$promise.then (response) ->
            photo.thumb = response.thumb
            photo.fetchingImage = false
            photo.retrievedImage = true
      , 0

    fetchPhotos = -> angular.forEach scope.photos, fetchPhoto
    scope.$watchCollection 'photos', fetchPhotos
