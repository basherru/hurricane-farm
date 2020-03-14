# frozen_string_literal: true

class Engine::Submit::Process < ApplicationService
  builds { Utils.get_class(name, config.check_system_protocol) }

  attr_accessor :current_flag
  delegate :check_system_ip,
           :check_system_port,
           :check_system_connect_timeout,
           :check_system_send_timeout,
           :check_system_recv_timeout,
           to: :config

  def call
    success! process!
  end

  # @!method prepare!, submit!, finalize!

  private

  def prepare!; end

  def finalize!; end

  def process!
    prepare!
    flags.each do |flag|
      self.current_flag = flag
      submit!
    end
  ensure
    finalize!
  end

  memoize def flags
    Flag.initial
  end
end
