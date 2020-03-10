class Engine::Stream::Persist < ApplicationService
  struct :team, :exploit, :stream

  def call
    success! persist_stream!
  end

  private

  def persist_stream!
    Flag.import(wrapped_flags, on_duplicate_key_ignore: true)
  end

  memoize def wrapped_flags
    filtered_flags.map { |content| wrap(content) }
  end

  def filtered_flags
    Engine::Stream::Filter.call(stream).response
  end

  def wrap(content)
    {
      exploit_id: exploit.id,
      team_id: team.id,
      content: content,
    }
  end
end