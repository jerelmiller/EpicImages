class EpicImages.Views.AddPhotos extends Backbone.View
  template: JST['backbone/templates/photos/add_photos_template']

  events:
    'click .save'            : 'save'
    'mouseover .filePicker'  : 'addHover'
    'mouseleave .filePicker' : 'removeHover'

  initialize: =>
    @$el.modal
      keyboard: false
      backdrop: 'static'
      show: false

    @$el.on 'shown', @_styleFileInput
    @$el.on 'showProgressBar', '.photoUploads', @_showProgressBar
    @$el.on 'finishedUploading', '.photoUploads', @_hideUploadingText

  render: =>
    @$el.html @template()
    @fileUploader = new EpicImages.Views.FileUploader
      el: '.photoUploads'
      fileElement: @$('input[type=file]')
      globalProgressCallback: @_calculateGlobalProgress

    @fileUploader.render()
    @

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

    progressWidth = @$('.modal-body').width() - @$('.inputContainer').outerWidth() - 40
    @$('.progress.global').css 'width', "#{progressWidth}px"

  _calculateGlobalProgress: (progress) =>
    @$('.progress.global .bar').animate
      width: "#{progress}%"

  _showProgressBar: =>
    @$('.progress.global, .uploading').show()

  _hideUploadingText: =>
    @$('.uploading').hide()

  save: =>
    console.log 'save clicked'