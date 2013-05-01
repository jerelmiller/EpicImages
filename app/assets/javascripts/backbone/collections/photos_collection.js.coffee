class EpicImages.Collections.Photos extends Backbone.Collection
  model: EpicImages.Models.Photo

  averageProgress: =>
    modelProgress = @models.reduce (memo, photo) =>
      memo += photo.get('progress')
    , 0

    modelProgress / @length

  isAllFinished: =>
    _.all @models, (photo) =>
      photo.get('progress') == 100


  toJSON: (options) =>
    _.extend {},
      photos: @map (model) => model.toJSON(options)

  save: =>
    @sync 'update', @, url: "/admin/photos/update_all"