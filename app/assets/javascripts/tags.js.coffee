$ ->
  $('.tagInput').select2
    tags: ['test', 'test2']
    width: '50%'
    tokenSeparators: [',']


  # @$('input#codes').select2
  #   formatResult: @formatResult
  #   formatSelection: @formatSelection
  #   width: '100%'
  #   data: @collection.map(@wrapCode)
  #   escapeMarkup: (m) => m
  #   multiple: true