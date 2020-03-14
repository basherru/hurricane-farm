# frozen_string_literal: true

class Engine::Run::TemporarilyExecutable::Process::Watch < ApplicationService
  struct :path, :pid, :exploit

  def call
    success! watch_process!
  end

  private

  def watch_process!
    Thread.new { watch_timeout! }
  end

  def watch_timeout!
    Timeout.timeout(exploit.timeout) { Process.wait(pid) }
  ensure
    try_kill_process!
    try_delete_executable!
  end

  def try_delete_executable!
    FileUtils.remove_file(path) rescue nil
  end

  def try_kill_process!
    Process.kill("TERM", pid) rescue nil
  end

  def log_timeout!
    logger.warn("Exploit #{exploit.title}: process timeout")
  end
end
