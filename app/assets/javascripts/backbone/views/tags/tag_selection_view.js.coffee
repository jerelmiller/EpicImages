class EpicImages.Views.TagSelection extends Backbone.View

  template: JST['backbone/templates/tags/tag_selection_template']

  initialize: =>
    @render = _.once @render

  render: =>
    @$el.html @template _.extend {}, @options, tags: @collection.models, searchedTags: @options.tagData

    if @options.type == 'select'
      @_selector().select2
        escapeMarkup: (m) => m
        width: 'element'
        placeholder: 'Search for photos'
        separator: ','

      @_selector().on 'change', @appendToHiddenField
    else
      @_selector().select2
        escapeMarkup: (m) => m
        width: 'element'
        tags: @collection.map(@wrapTag)

    @updateView()

  updateView: =>
    if @options.tagData
      tags = @options.tagData.map @wrapTag
      @_selector().select2 'data', tags
      @

  createSearchChoice: (term) =>
    @wrapTag(new Analyze.Models.Tag(name: $.trim(term)))

  wrapTag: (tag) =>
    id: tag.get('name') || 'default'
    text: tag.get('name') || 'default'
    tag: tag

  _selector: =>
    return @$('input#tags') if @options.type != 'select'
    @$("select.search")

  appendToHiddenField: (e) =>
    vals = _.compact @$('input[name=search]').val().split(';')
    if e.added
      vals.push e.added.text
    else if e.removed
      vals = _.without vals, e.removed.text
    @$('input[name=search]').val vals.join(';')