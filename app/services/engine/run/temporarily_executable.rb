# frozen_string_literal: true

class Engine::Run::TemporarilyExecutable < ApplicationService
  struct :team, :exploit
  attr_accessor :path, :pid, :stdout

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
    response = Engine::Run::TemporarilyExecutable::Process::Spawn.call(team, exploit).response

    self.path, self.pid, self.stdout = response.values_at(:path, :pid, :stdout)
  end

  def watch_process!
    Engine::Run::TemporarilyExecutable::Process::Watch.call(path, pid, exploit)
  end

  def persist_stream!
    Engine::Stream::Persist.call(team, exploit, stdout)
  end
end
