class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  before_save {email.try(:downcase)}
end
