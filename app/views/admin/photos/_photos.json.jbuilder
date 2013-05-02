json.(photos) do |json, photo|
  json.partial! photo
end