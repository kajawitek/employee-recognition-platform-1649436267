class Employee < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :given_kudos, class_name: 'Kudo', foreign_key: 'giver_id', dependent: :destroy, inverse_of: :giver
  has_many :received_kudos, class_name: 'Kudo', foreign_key: 'receiver_id', dependent: :destroy, inverse_of: :receiver
  has_many :orders, dependent: :destroy
  has_one :address, dependent: :destroy
  has_many :online_codes, dependent: :destroy

  validates :first_name, :last_name, presence: true

  def full_name
    [first_name, last_name].join(' ')
  end
end
