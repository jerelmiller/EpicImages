class EpicImages.Views.TagSelection extends Backbone.View

  render: =>
    @$el.html "<input id=\"tags\" type=\"text\" name=\"tags\">"

    @$('input#tags').select2
      createSearchChoice: @createSearchChoice
      escapeMarkup: (m) => m
      width: 'element'
      tags: @collection.map(@wrapTag)
      width: '100%'

    @updateView()

  updateView: =>
    if @options.photoTags
      tags = @options.photoTags.map @wrapTag
      @$('input#tags').select2 'data', tags
      @

  createSearchChoice: (term) =>
    @wrapTag(new Analyze.Models.Tag(name: $.trim(term)))

  wrapTag: (tag) =>
    id: tag.get('name') || 'default'
    text: tag.get('name') || 'default'
    tag: tag