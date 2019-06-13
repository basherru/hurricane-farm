class Team < ApplicationRecord
  has_and_belongs_to_many :exploits
  has_many :flags

  validates :title, :host, presence: true

  enum status: %i[down up]

  include TeamChartsScopes
end
