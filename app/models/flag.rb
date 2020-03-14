# frozen_string_literal: true

class Flag < ApplicationRecord
  belongs_to :team, optional: true
  belongs_to :exploit, optional: true

  validates :content, :pts, presence: true
  validates :content, uniqueness: true

  enum status: { initial: 0, accepted: 1, already_posted: 2, too_old: 3, our_own: 4 }
end
