class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :recipes, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :agreed_to_terms_and_conditions, :agreed_to_privacy_and_policy, acceptance: {message: "You must agree before submitting"}
end
