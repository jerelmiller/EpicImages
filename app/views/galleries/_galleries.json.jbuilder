json.(galleries) do |json, gallery|
  json.partial! gallery
end