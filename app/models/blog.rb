class Blog < ActiveRecord::Base

  attr_accessible :title, :body

  validates :title, :body, presence: true
  validates :title, uniqueness: true

  TRUNCATE_LENGTH = 1000

  def self.order_most_recent
    order('created_at desc')
  end

  def self.most_recent
    order_most_recent.first
  end

  def to_param
    "#{id}-#{title.parameterize}"
  end
end