class Tag < ActiveRecord::Base
  has_and_belongs_to_many :photos
  belongs_to :gallery_photo, class_name: 'Photo', foreign_key: 'photo_id'

  attr_accessible :name, :gallery_photo, :gallery_flag

  validates :name, presence: true, uniqueness: true

  def self.gallery
    where gallery_flag: true
  end

  def self.with_photos
    joins{ photos }
  end

  def gallery?
    gallery_flag
  end

  def self.destroy_unused!
    ActiveRecord::Base.transaction do
      includes{ photos }.select{ |tag| tag.photos.length < 1 && !tag.gallery? }.map(&:destroy)
    end
  end

  def to_param
    name.parameterize
  end
end