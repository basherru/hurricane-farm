# frozen_string_literal: true

class Engine::Runner::TemporarilyExecutable::Process::Spawn < ApplicationService
  struct :team, :exploit

  def call
    success! spawn_process!
  end

  private

  def spawn_process!
    create_directory!
    create_executable!
    allow_execution!
    stdout, _, pid = PTY.spawn(start_cmd)

    { path: executable_rel_path, pid: pid, stdout: stdout }
  end

  def start_cmd
    "./#{executable_rel_path} #{team.host}"
  end

  def create_directory!
    FileUtils.mkdir_p("exploits")
  end

  def create_executable!
    File.write(executable_rel_path, executable_content)
  end

  def allow_execution!
    FileUtils.chmod("+x", executable_rel_path)
  end

  def executable_content
    Utils.to_local_delimiter(exploit.source)
  end

  memoize def executable_rel_path
    File.join("exploits", executable_name)
  end

  memoize def executable_name
    SecureRandom.base58(32)
  end
end
