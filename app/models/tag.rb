class Tag < ActiveRecord::Base
  has_and_belongs_to_many :photos

  attr_accessible :name

  validates :name, uniqueness: true
end