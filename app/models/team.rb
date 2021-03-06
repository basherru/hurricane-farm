# frozen_string_literal: true

class Team < ApplicationRecord
  has_and_belongs_to_many :exploits
  has_many :flags

  validates :title, :host, presence: true

  enum status: { down: 0, up: 1 }

  after_save do
    exploits.each { |exploit| Engine::Exploit::AfterSave.call(exploit) }
  end
end
