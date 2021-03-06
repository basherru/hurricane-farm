# frozen_string_literal: true

class Engine::Submit::Process::Tcp < Engine::Submit::Process
  READ_AT_ONCE = 1024

  attr_accessor :response

  private

  def prepare!
    read_all_void!
    send_token!
    read_all_void!
  rescue IO::WaitReadable
  end

  def submit!
    send_flag!
    receive_response!
    update_flag!
  end

  def finalize
    socket.close
  end

  def send_token!
    Timeout.timeout(check_system_send_timeout) { socket.puts(check_system_token) }
  end

  def send_flag!
    Timeout.timeout(check_system_send_timeout) { socket.puts(current_flag.content) }
  end

  def read_all_void!
    Timeout.timeout(check_system_recv_timeout) { socket.recv(READ_AT_ONCE) }
  end

  def receive_response!
    self.response =
      Timeout.timeout(check_system_recv_timeout) { socket.recv(READ_AT_ONCE) }
  end

  def update_flag!
    return if current_flag.status == status

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
    response[/\d+[.,]\d+/].to_f
  end

  memoize def socket
    Timeout.timeout(check_system_connect_timeout) do
      TCPSocket.new(check_system_ip, check_system_port)
    end
  end
end
