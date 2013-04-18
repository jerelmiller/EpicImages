class Photo < ActiveRecord::Base
  has_and_belongs_to_many :tags

  attr_accessible :title, :image, :featured_flag

  has_attached_file :image,
    storage: :dropbox,
    styles: { thumb: '300x200>', cropped: '750x500#' },
    dropbox_credentials: "#{Rails.root}/config/dropbox.yml",
    dropbox_options: { path: proc { |style| "epicimages/#{Rails.env}/photos/#{style}/#{id}/#{image.original_filename}"} }

    validates_attachment :image, presence: { message: 'must be present' },
      content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] }

  def self.featured
    where(featured_flag: true)
  end
end