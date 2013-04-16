class Gallery < ActiveRecord::Base
  attr_accessible :name, :cover_photo
  validates :name, presence: true, uniqueness: true

  has_attached_file :cover_photo,
    storage: :dropbox,
    styles: { cropped: '300x200#' },
    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
    dropbox_options: { path: proc { |style| "epicimages/#{Rails.env}/cover_photos/#{style}/#{id}/#{cover_photo.original_filename}"} }

    validates_attachment :cover_photo, presence: { message: 'must be present' },
      content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }

  def to_param
    name.parameterize
  end

  def to_s
    name
  end
end