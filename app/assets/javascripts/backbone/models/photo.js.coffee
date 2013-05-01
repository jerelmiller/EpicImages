class EpicImages.Models.Photo extends Backbone.Model

  urlRoot: '/admin/photos'

  defaults:
    caption: ''
    src: ''
    progress: 0

  initialize: =>
    @listenTo @, 'change:image', @_setName
    @listenTo @, 'change:progress', @triggerFinished

  submitImage: =>
    _.delay =>
      @get('image').submit()
    , 200

  triggerFinished: =>
    @trigger 'finishedUploading' if @get('progress') == 100

  _setName: =>
    @set 'name', @get('image').files[0].name

  toJSON: (options) =>
    attrs = _.clone @attributes
    delete attrs.image
    delete attrs.progress
    delete attrs.width
    attrs