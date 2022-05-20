class CompanyValue < ApplicationRecord
  validates :title, presence: true, uniqueness: true
end
