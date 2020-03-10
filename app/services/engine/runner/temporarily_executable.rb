class Engine::Runner::TemporarilyExecutable < ApplicationService
  struct :team, :exploit
  attr_accessor :pid, :stdout

  def call
    success! process!
  end

  private

  def process!
    spawn_process!
    watch_process!
    persist_stream!
  end

  def spawn_process!
    response = Engine::Runner::TemporarilyExecutable::Process::Spawn.call(team, exploit).response

    self.pid, self.stdout = response.values_at(:pid, :stdout)
  end

  def watch_process!
    Engine::Runner::TemporarilyExecutable::Process::Watch.call(pid, exploit)
  end

  def persist_stream!
    Engine::Stream::Persist.call(team, exploit, stdout)
  end
end