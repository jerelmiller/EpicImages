json.(gallery,
  :id,
  :name
)

json.src gallery.cover_photo.url(:cropped)
json.show_link gallery_path(gallery)