class EpicImages.Models.Photo extends Backbone.Model

  urlRoot: '/admin/photos'

  defaults:
    caption: ''
    src: ''
    progress: 0

  initialize: =>
    @listenTo @, 'change:image', @_setName
    @listenTo @, 'change:progress', @_triggerFinished
    @listenTo @, 'change:failed', @_triggerFailed

  submitImage: =>
    _.delay =>
      @set 'xhr', @get('image').submit()
    , 200

  hasFinished: =>
    @get('progress') == 100 && !@get('failed')

  cancelUpload: =>
    @get('xhr').abort()
    @trigger 'abort'

  hasFailed: =>
    @get('failed')

  inProgress: =>
    @get('in_progress')

  _triggerFinished: =>
    @trigger 'finished' if @hasFinished()

  _triggerFailed: =>
    @trigger 'fail' if @hasFailed()

  _setName: =>
    @set 'name', @get('image').files[0].name

  toJSON: (options) =>
    attrs = _.clone @attributes
    delete attrs.image
    delete attrs.progress
    delete attrs.width
    delete attrs.failed
    delete attrs.in_progress
    attrs