module HurricaneEngine
  module Runner
    class ShebangRunner
      class << self
        def run(team, exploit)
          executable = create_temp_executable(exploit.source)
          cmd  = "./#{executable} #{team.host}"
          stdout, _, pid = PTY.spawn(cmd)
          Thread.new { watch_process(pid, exploit.timeout) }
          register_flags(stdout, team, exploit)
        rescue PTY::ChildExited => _
        ensure
          File.delete(executable)
        end

        private

        def create_temp_executable(source)
          temp_file_name = SecureRandom.base58(32)
          File.write(temp_file_name, source.gsub("\r\n", "\n"))
          FileUtils.chmod("+x", temp_file_name)
          temp_file_name
        end

        def watch_process(pid, timeout)
          Timeout.timeout(timeout) { Process.wait(pid) }
        rescue Timeout::Error => _
          Process.kill('TERM', pid)
        end

        def register_flags(stream, team, exploit)
          stream.each do |line|
            line.scan(App.config.flag_format).each do |content|
              Flag.create(team_id: team.id, exploit_id: exploit.id, content: content)
            end
          end
        rescue Errno::EIO => _
        end
      end
    end
  end
end