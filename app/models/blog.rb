class Blog < ActiveRecord::Base

  attr_accessible :title, :body

  validates :title, :body, presence: true
  validates :title, uniqueness: true

  def self.most_recent
    order('created_at desc').last
  end
end