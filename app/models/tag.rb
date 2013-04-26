class Tag < ActiveRecord::Base
  has_and_belongs_to_many :photos
  belongs_to :gallery_photo, class_name: 'Photo', foreign_key: 'photo_id'

  attr_accessible :name, :gallery_photo

  validates :name, presence: true, uniqueness: true
  validate :gallery_photo_is_a_gallery

  def self.gallery
    where gallery_flag: true
  end

  def self.destroy_unused!
    ActiveRecord::Base.transaction do
      includes{ photos }.select{ |tag| tag.photos.length < 1 }.map(&:destroy)
    end
  end

  def to_param
    name.parameterize
  end

  private

    def gallery_photo_is_a_gallery
      errors.add :base, 'You must make this tag a gallery if you want to add a cover photo' if self.photo_id.present? && !self.gallery_flag
      errors.add :base, 'You must add a gallery photo if you want to make this tag a gallery' if self.gallery_flag && self.photo_id.nil?
    end
end