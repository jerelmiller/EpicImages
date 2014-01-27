class EpicImages.Views.AddPhotos extends Backbone.View
  template: JST['backbone/templates/photos/add_photos_template']
  modalOverlay: JST['backbone/templates/modals/modal_overlay']
  error: JST['backbone/templates/alerts/error']

  events:
    'click .save:not(.disabled)'   : 'save'
    'click .cancel:not(.disabled)' : 'cancel'
    'mouseover .filePicker'        : 'addHover'
    'mouseleave .filePicker'       : 'removeHover'
    'blur .filePicker'             : 'removeHover'

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
    @$el.on 'recalculateLayout', '.photoUploads', @_recalculateLayout

  render: =>
    @$el.html @template()
    @fileUploader = new EpicImages.Views.FileUploader
      el: '.photoUploads'
      dropZone: @$el
      fileElement: @$('input[type=file]')
      globalProgressCallback: @_calculateGlobalProgress
      tags: @options.tags
      autoApplyTags: @defaultAppliedTags
      collection: @collection

    @fileUploader.render()
    @

  applyDefaultTag: (tag) => @fileUploader.addDefaultTag tag

  save: =>
    @showLoading()
    @collection.save success: @onSaveSuccess, error: @renderError

  cancel: =>
    if @collection.length > 0
      if confirm "You've already uploaded some photos. Do you want to cancel and delete these photos?"
        _.each @collection.models, (photo) =>
          photo.destroy()

        @$el.modal 'hide'
        @$el.on 'hidden', @resetView
    else
      @$el.modal 'hide'

  onSaveSuccess: =>
    @removeLoading()
    @$el.modal 'hide'
    @$el.on 'hidden', @resetView
    _.delay(=> @trigger 'saved', 200)

  renderError: =>
    @removeLoading()
    @$('.alertMessage').html @error text: "There was an error while saving. Please try again"

  showLoading: =>
    @$el.spin()
    @$el.append @modalOverlay()

  removeLoading: =>
    @$('.modal-overlay').remove()
    @$el.spin false

  resetView: =>
    @fileUploader.remove()
    @collection.reset()
    @render()

  addHover: => @$('.chooseFile').addClass 'hover'
  removeHover: => @$('.chooseFile').removeClass 'hover'

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

  _showProgressBar: => @$('.progress.global, .uploading').show()
  _hideUploadingText: => @$('.uploading').hide()

  _showUploadingText: => @$('.uploading').show()

  _recalculateLayout: =>
    _.defer =>
      @$('.photoUploads').masonry 'destroy' if @$('.photoUploads').data 'masonry'
      @$('.photoUploads').masonry
        itemSelector: '.photoUpload'
        isAnimated: true

  _disableButtons: =>
    @$('.save').addClass 'disabled'
    @$('.cancel').addClass 'disabled'

  _enableButtons: =>
    @$('.save').removeClass 'disabled'
    @$('.cancel').removeClass 'disabled'

  _bindListeners: =>
    @listenTo @collection, 'resubmit', @_disableButtons
    @listenTo @collection, 'resubmit', @_showUploadingText
    @listenTo @collection, 'success failed', @_hideUploadingText
    @listenTo @collection, 'success', @_enableButtons
    @listenTo @collection, 'add finished fail', @_recalculateLayout # Listen for individual model success and fail
    @listenTo @collection, 'add', @_disableButtons