class EpicImages.Views.FileUploader extends Backbone.View

  initialize: =>
    @$fileElement = @options.fileElement
    @subviews = []
    @_bindListeners()

  render: =>
    @$fileElement.fileupload @_fileUploadOptions()
    @

  renderPhoto: (photo) =>
    photoView = new EpicImages.Views.AddedPhoto
      model: photo
      tags: @options.tags

    @$el.append photoView.render().el

    @subviews.push photoView
    photoView.submitImage()

  _fileUploadOptions: =>
    _.extend {},
      dataType: 'json'
      url: '/admin/photos'
      paramName: 'photo[image]'
      add: @_addFile
      progress: @_calculateProgress
      done: @_finishedUploading
      change: @_showGlobalProgressBar
      fail: @_renderFailed

  _addFile: (e, image) =>
    newPhoto = new EpicImages.Models.Photo()
    image._id = @collection.length
    newPhoto.set 'image', image
    @collection.add newPhoto
    @$el.trigger 'recalculateLayout'

  _calculateProgress: (e, image) =>
    progress = parseInt(image.loaded / image.total * 100, 10)
    progress = 95 if progress > 95
    @_findSubviewFor(image._id).setProgress progress

  _finishedUploading: (e, image) =>
    view = @_findSubviewFor(image._id)
    view.model.set @_completedPhotoAttrs(image)
    view.setProgress 100
    @$el.trigger 'finishedUploading' if @collection.isAllFinished()
    @$el.trigger 'recalculateLayout'

  _renderFailed: (e, image) =>
    view = @_findSubviewFor(image._id)
    view.renderFailed()
    view.model.set 'progress', 99
    @$el.trigger 'recalculateLayout'

  _showGlobalProgressBar: =>
    @$el.trigger 'showProgressBar'

  _findSubviewFor: (id) =>
    _.chain(@subviews).filter((subview) => subview.model.get('image')._id == id).first().value()

  _bindListeners: =>
    @listenTo @collection, 'add', @renderPhoto
    @listenTo @collection, 'change:progress', @_calculateGlobalProgress

  _calculateGlobalProgress: =>
    @options.globalProgressCallback @collection.averageProgress()

  _completedPhotoAttrs: (image) =>
    JSON.parse(image.jqXHR.responseText)