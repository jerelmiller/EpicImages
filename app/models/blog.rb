class Blog < ActiveRecord::Base

  attr_accessible :title, :body

  validates :title, :body, presence: true
  validates :title, uniqueness: true
end