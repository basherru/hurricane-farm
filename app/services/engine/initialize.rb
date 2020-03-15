# frozen_string_literal: true

class Engine::Initialize < ApplicationService
  def call
    success! initialize!
  end

  private

  def initialize!
    initialize_schedules!
    initialize_queues!
    initialize_submit_loop!
  end

  def initialize_schedules!
    exploits.each { |exploit| Engine::Exploit::AfterSave.call(exploit) }
  end

  def initialize_queues!
    queues.map(&:new).each(&:clear)
  end

  def initialize_submit_loop!
    Engine::Submit::Loop.call
  end

  def exploits
    ::Exploit.all
  end

  def queues
    [Sidekiq::RetrySet, Sidekiq::ScheduledSet, Sidekiq::DeadSet]
  end
end
