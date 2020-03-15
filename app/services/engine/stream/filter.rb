# frozen_string_literal: true

class Engine::Stream::Filter < ApplicationService
  struct :stream
  delegate :flag_format, to: :config

  def call
    success!(unique_filtered_entries)
  end

  private

  def unique_filtered_entries
    filtered_entries.uniq
  end

  def filtered_entries
    stream.flat_map { |line| line.scan(flag_format) } rescue []
  end
end
