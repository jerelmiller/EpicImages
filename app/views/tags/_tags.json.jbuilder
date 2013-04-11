json.(tags) do |json, tag|
  json.partial! 'tags/tag', tag: tag
end