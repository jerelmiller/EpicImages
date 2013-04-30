json.(photo,
  :id,
  :featured_flag
)

json.thumb photo.image.url(:thumb)
json.width photo.image.width(:thumb)
json.height photo.image.height(:thumb)
