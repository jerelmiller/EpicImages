json.(tag,
  :id,
  :name
)


json.src tag.try(:gallery_photo).try(:image).try(:url, :thumb_cropped) || tag.photos.first.try(:image).try(:url, :thumb_cropped)
json.no_photos tag.photos.empty?
json.show_link tag_path(tag)
json.show_link admin_tag_path(tag) if request.path.include? 'admin'