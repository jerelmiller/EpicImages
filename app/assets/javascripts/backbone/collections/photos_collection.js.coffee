class EpicImages.Collections.Photos extends Backbone.Collection
  model: EpicImages.Models.Photo
  url: '/admin/photos/all_photos'

  initialize: =>
    @listenTo @, 'fail', @_triggerFailed
    @listenTo @, 'finished abort', @_triggerSuccess

  averageProgress: =>
    modelProgress = @models.reduce (memo, photo) =>
      memo += photo.get('progress')
    , 0

    modelProgress / @length

  allHasFinished: =>
    _.all @models, (photo) => photo.hasFinished()

  allHasFailed: =>
    _.all @models, (photo) => photo.hasFailed()

  anyInProgress: =>
    _.any @models, (photo) => photo.inProgress()

  anyHasFinished: =>
    _.any @models, (photo) => photo.hasFinished()

  toJSON: (options) =>
    _.extend {},
      photos: @map (model) => model.toJSON(options)

  save: (options) =>
    options = _.extend url: "/admin/photos/update_all", options
    @sync 'update', @, options

  _triggerFailed: =>
    @trigger 'failed' if @allHasFailed()

  _triggerSuccess: =>
    @trigger 'success' if @allHasFinished() || (@anyHasFinished() && !@anyInProgress())