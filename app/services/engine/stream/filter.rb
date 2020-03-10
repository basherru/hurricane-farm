class Engine::Stream::Filter < ApplicationService
  struct :stream
  delegate :flag_format, to: :config

  def call
    success!(filtered_entries)
  end

  private

  def filtered_entries
    stream.flat_map { |line| line.scan(flag_format) } rescue []
  end
end