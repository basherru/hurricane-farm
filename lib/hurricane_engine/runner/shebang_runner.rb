module HurricaneEngine
  module Runner
    class ShebangRunner
      class << self
        def run(team, exploit)
          temp_file_name = SecureRandom.base58(32)
          File.write(temp_file_name, exploit.source.gsub("\r\n", "\n"))
          FileUtils.chmod("+x", temp_file_name)
          cmd  = "./#{temp_file_name} #{team.host}"
          begin
            stdout, _, pid = PTY.spawn(cmd)
            Thread.new do
              begin
                Timeout.timeout(exploit.timeout) { Process.wait(pid) }
              rescue Timeout::Error => _
                Process.kill('TERM', pid)
                Rails.logger.warn "Timeout #{exploit.title.green} => #{team.handle.red}"
              end
            end
            begin
              stdout.each do |line|
                line.scan(App.config.flag_format).each do |content|
                  Flag.create(team_id: team.id, exploit_id: exploit.id, content: content)
                end
              end
            rescue Errno::EIO => _
            end
          rescue PTY::ChildExited => _
            Rails.logger.info "Error #{exploit.title.green} for #{team.handle.red}"
          end
        ensure
          File.delete(temp_file_name)
        end
      end
    end
  end
end