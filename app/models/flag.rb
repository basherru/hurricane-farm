class Flag < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :exploit, optional: true

  validates :content, :pts, presence: true
  validates :content, uniqueness: true

  enum status: %i[initial enqueued posted]
end
