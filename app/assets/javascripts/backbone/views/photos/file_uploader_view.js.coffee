class EpicImages.Views.FileUploader extends Backbone.View

  initialize: =>
    @$fileElement = @options.fileElement
    @subviews = []
    @collection = new EpicImages.Collections.Photos()
    @_bindListeners()

  render: =>
    @$fileElement.fileupload @_fileUploadOptions()
    @

  renderPhoto: (photo) =>
    photoView = new EpicImages.Views.AddedPhoto
      id: photo.get('name')
      model: photo

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

  _addFile: (e, image) =>
    newPhoto = new EpicImages.Models.Photo()
    newPhoto.set 'image', image

    @collection.add newPhoto

  _calculateProgress: (e, image) =>
    progress = parseInt(image.loaded / image.total * 100, 10)
    progress = 95 if progress > 95
    @_findSubviewFor(image.files[0].name).setProgress progress

  _finishedUploading: (e, image) =>
    @_findSubviewFor(image.files[0].name).renderFinished()
    @$el.trigger 'finishedUploading' if @collection.isAllFinished()

  _showGlobalProgressBar: =>
    @$el.trigger 'showProgressBar'

  _findSubviewFor: (id) =>
    _.chain(@subviews).where(id: id).first().value()

  _bindListeners: =>
    @listenTo @collection, 'add', @renderPhoto
    @listenTo @collection, 'change:progress', @_calculateGlobalProgress

  _calculateGlobalProgress: =>
    @options.globalProgressCallback @collection.averageProgress()