json.(tag,
  :id,
  :name
)

json.src tag.try(:gallery_photo).try(:image).try(:url, :thumb_cropped)
json.show_link tag_path(tag)