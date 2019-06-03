class Team < ApplicationRecord
  has_and_belongs_to_many :exploits
  has_many :flags

  validates :title, :host, :status, presence: true
end
