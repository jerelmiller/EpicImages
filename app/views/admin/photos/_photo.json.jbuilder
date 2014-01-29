json.(photo,
  :id,
  :featured_flag
)

json.width photo.image.width(:thumb)
json.height photo.image.height(:thumb)
json.edit_link edit_admin_photo_path(photo)