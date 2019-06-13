class Flag < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :exploit, optional: true

  validates :content, :pts, presence: true
  validates :content, uniqueness: true

  extend Helpers::GroupableByMinutes

  enum status: %i[initial enqueued already_posted too_old our_own accepted]
end
