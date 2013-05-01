class EpicImages.Views.AddPhotos extends Backbone.View
  template: JST['backbone/templates/photos/add_photos_template']
  modalOverlay: JST['backbone/templates/modals/modal_overlay']

  events:
    'click .save:not(.disabled)'  : 'save'
    'mouseover .filePicker'       : 'addHover'
    'mouseleave .filePicker'      : 'removeHover'
    'blur .filePicker'            : 'removeHover'

  initialize: =>
    @$el.modal
      keyboard: false
      backdrop: 'static'
      show: false

    @_calculateGlobalProgress = _.debounce @_calculateGlobalProgress, 100
    @_recalculateLayout = _.debounce @_recalculateLayout, 500
    @collection = new EpicImages.Collections.Photos()

    @_bindListeners()

    @$el.on 'shown', @_styleFileInput
    @$el.on 'showProgressBar', '.photoUploads', @_showProgressBar
    @$el.on 'finishedUploading', '.photoUploads', @_hideUploadingText
    @$el.on 'finishedUploading', '.photoUploads', @_enableSaveButton
    @$el.on 'recalculateLayout', '.photoUploads', @_recalculateLayout

  render: =>
    @$el.html @template()
    @fileUploader = new EpicImages.Views.FileUploader
      el: '.photoUploads'
      fileElement: @$('input[type=file]')
      globalProgressCallback: @_calculateGlobalProgress
      tags: @options.tags
      collection: @collection

    @fileUploader.render()
    @

  save: =>
    @$el.spin()
    @$el.append @modalOverlay()
    @collection.save()

  addHover: =>
    @$('.chooseFile').addClass 'hover'

  removeHover: =>
    @$('.chooseFile').removeClass 'hover'

  _styleFileInput: =>
    height = @$('.chooseFile').outerHeight()
    @$('input[type=file], .inputContainer').css
      width: "#{@$('.chooseFile').outerWidth()}px"
      height: "#{height}px"
    @$('.fileInput').css 'height', "#{height}px"

    progressWidth = @$('.modal-body').width() - @$('.inputContainer').width() - 50
    @$('.progress.global').css 'width', "#{progressWidth}px"

  _calculateGlobalProgress: (progress) =>
    @$('.progress.global .bar').animate
      width: "#{progress}%"

  _showProgressBar: =>
    @$('.progress.global, .uploading').show()

  _hideUploadingText: =>
    @$('.uploading').hide()

  _recalculateLayout: =>
    _.defer =>
      @$('.photoUploads').masonry 'destroy'
      @$('.photoUploads').masonry
        itemSelector: '.photoUpload'
        isAnimated: true

  _disableSaveButton: =>
    @$('.save').addClass 'disabled'

  _enableSaveButton: =>
    @$('.save').removeClass 'disabled'

  _bindListeners: =>
    @listenTo @collection, 'add', @_disableSaveButton