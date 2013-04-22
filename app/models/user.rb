class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body

  validates :password, presence: true, confirmation: true, on: :create
  validates :password, presence: true, confirmation: true, on: :update, unless: lambda { self.password.blank? }
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  def to_s
    "#{first_name} #{last_initial}"
  end

  private

    def last_initial
      "#{last_name.split('').first}."
    end
end
