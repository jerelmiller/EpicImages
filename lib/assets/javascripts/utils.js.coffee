String.prototype.truncate = (strLen, separator) ->
  return @split('').join('') if @length <= strLen

  separator = separator || '...'

  sepLen = separator.length
  charsToShow = strLen - sepLen
  frontChars = Math.ceil charsToShow / 2
  backChars = Math.floor charsToShow / 2

  @substr(0, frontChars) + separator + @substr(@length - backChars)