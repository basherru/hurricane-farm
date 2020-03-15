# frozen_string_literal: true

class Engine::Submit::Process < ApplicationService
  builds { Utils.get_class(name, config.check_system_protocol) }

  attr_accessor :current_flag
  delegate :check_system_ip,
           :check_system_port,
           :check_system_connect_timeout,
           :check_system_send_timeout,
           :check_system_recv_timeout,
           :check_system_max_batch_size,
           :check_system_submit_ttl,
           to: :config

  def call
    success! process!
  end

  # @!method prepare!, submit!, finalize!

  private

  def prepare!; end

  def finalize!; end

  def process!
    return if flags.none?

    prepare!
    submit_many!
  ensure
    finalize!
  end

  def submit_many!
    flags.each do |flag|
      self.current_flag = flag
      submit!
    end
  end

  def flags
    Flag
      .initial
      .where(created_at: ttl_range)
      .order(created_at: :desc)
      .take(check_system_max_batch_size)
  end

  def ttl_range
    Range.new(check_system_submit_ttl.seconds.ago, Time.current)
  end
end
