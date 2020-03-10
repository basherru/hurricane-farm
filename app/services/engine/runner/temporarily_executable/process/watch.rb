class Engine::Runner::TemporarilyExecutable::Process::Watch < ApplicationService
  struct :pid, :exploit

  def call
    success! watch_process!
  end

  private

  def watch_process!
    Thread.new { watch_timeout! }
  end

  def watch_timeout!
    Timeout.timeout(exploit.timeout) { Process.wait(pid) }
  rescue Timeout::Error => _
    logger.warn("Exploit #{exploit.title}: process timeout")
    Process.kill('TERM', pid)
  end
end