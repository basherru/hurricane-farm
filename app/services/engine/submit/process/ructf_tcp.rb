# frozen_string_literal: true

class Engine::Submit::Process::RuctfTcp < Engine::Submit::Process
  READ_AT_ONCE = 1024

  attr_accessor :response

  private

  def prepare!
    Timeout.timeout { socket.recv_nonblock(READ_AT_ONCE) }
  rescue IO::WaitReadable
  end

  def submit!
    send!
    self.response = socket.recv_nonblock(READ_AT_ONCE)
    update_flag!
  rescue IO::WaitReadable
    retry
  end

  def finalize
    socket.close
  end

  def send!
    Timeout.timeout(check_system_send_timeout) { socket.send(current_flag.content) }
  end

  def update_flag!
    return if current_flag.status != status

    current_flag.update!(status: status, pts: pts)
  end

  def status
    case response
    when /accepted|congrat/
      :accepted
    when /already/
      :already_posted
    when /old/
      :too_old
    when /own/
      :our_own
    else
      :initial
    end
  end

  def pts
    response[/\d+[.,]\d+/].to_i
  end

  memoize def socket
    Timeout.timeout(check_system_connect_timeout) do
      TCPSocket.new(check_system_ip, check_system_port)
    end
  end
end
