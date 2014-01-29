angular.module('galleryServices', ['ngResource'])
.factory 'Gallery', ($resource) ->
  $resource '/admin/galleries/:id/photos', { id: '@id' },
    photos: { method: 'GET', isArray: true }