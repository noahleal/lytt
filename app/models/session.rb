class Session < ApplicationRecord
  has_many :messages
  has_many :replies
  validates :identifier, uniqueness: true
end
