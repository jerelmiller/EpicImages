json.(photo,
  :id,
  :featured_flag
)

json.width photo.image.width(:thumb)
json.height photo.image.height(:thumb)