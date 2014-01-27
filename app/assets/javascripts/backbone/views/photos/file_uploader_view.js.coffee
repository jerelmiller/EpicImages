class EpicImages.Views.FileUploader extends Backbone.View

  initialize: =>
    @$fileElement = @options.fileElement
    @subviews = []
    @autoApplyTags = @options.autoApplyTags || []
    @_bindListeners()

  render: =>
    @$fileElement.fileupload @_fileUploadOptions()
    @

  renderPhoto: (photo) =>
    photoView = new EpicImages.Views.AddedPhoto
      model: photo
      tags: @options.tags
      autoApplyTags: @autoApplyTags

    @$el.append photoView.render().el

    @subviews.push photoView
    photoView.submitImage()

  addDefaultTag: (tag) => @autoApplyTags.push tag

  _fileUploadOptions: =>
    _.extend {},
      dataType: 'json'
      url: '/admin/photos'
      paramName: 'photo[image]'
      add: @_addFile
      progress: @_calculateProgress
      done: @_finishedUploading
      fail: @_renderFailed
      submit: @_setInProgress
      pasteZone: null
      dropZone: @options.dropZone

  _addFile: (e, image) =>
    @_showGlobalProgressBar()
    newPhoto = new EpicImages.Models.Photo()
    image._id = @collection.length
    newPhoto.set 'image', image
    @collection.add newPhoto

  _calculateProgress: (e, image) =>
    progress = parseInt(image.loaded / image.total * 100, 10)
    progress = 95 if progress > 95
    @_findSubviewFor(image._id).setProgress progress

  _finishedUploading: (e, image) =>
    view = @_findSubviewFor(image._id)
    view.model.set @_completedPhotoAttrs(image)
    view.setFailed false
    view.setInProgress false
    view.setProgress 100

  _renderFailed: (e, image) =>
    view = @_findSubviewFor(image._id)
    view.renderFailed()
    view.setFailed true
    view.setInProgress false
    view.setProgress 100

  _showGlobalProgressBar: =>
    @$el.trigger 'showProgressBar'

  _findSubviewFor: (id) =>
    _.chain(@subviews).filter((subview) => subview.model.get('image')._id == id).first().value()

  _bindListeners: =>
    @listenTo @collection, 'add', @renderPhoto
    @listenTo @collection, 'change:progress', @_calculateGlobalProgress

  _calculateGlobalProgress: =>
    @options.globalProgressCallback @collection.averageProgress()

  _setInProgress: (e, image) =>
    @_findSubviewFor(image._id).setInProgress true

  _completedPhotoAttrs: (image) =>
    JSON.parse(image.jqXHR.responseText)