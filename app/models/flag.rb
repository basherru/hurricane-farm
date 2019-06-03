class Flag < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :exploit, optional: true

  validates :content, :status, :pts, presence: true
  validates :content, uniqueness: true
end
