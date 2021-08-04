class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs
  has_many :companies
  has_many :projects

  # Profile Pic
  has_one_attached :image, service: :amazon

  # Geocoded address
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  # Votable / Like / unlike
  acts_as_voter

  validates :email, :username, uniqueness: true
  validates :terms_of_service, presence: true
end
