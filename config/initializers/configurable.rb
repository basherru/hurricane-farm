# frozen_string_literal: true

class App
  extend Dry::Configurable

  setting :flag_format, eval(ENV.fetch("FLAG_FORMAT"))
  setting :submit_interval, eval(ENV.fetch("SUBMIT_INTERVAL"))
  setting :check_system_protocol, ENV.fetch("CHECK_SYSTEM_PROTOCOL").downcase
  setting :check_system_ip, ENV.fetch("CHECK_SYSTEM_IP")
  setting :check_system_port, ENV.fetch("CHECK_SYSTEM_PORT")
  setting :check_system_connect_timeout, ENV.fetch("CHECK_SYSTEM_CONNECT_TIMEOUT")
  setting :check_system_send_timeout, ENV.fetch("CHECK_SYSTEM_SEND_TIMEOUT")
  setting :check_system_recv_timeout, ENV.fetch("CHECK_SYSTEM_RECV_TIMEOUT")
  setting :datatable_rating_size, ENV.fetch("DATATABLE_RATING_SIZE").to_i
end
