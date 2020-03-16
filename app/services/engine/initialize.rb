# frozen_string_literal: true

class Engine::Initialize < ApplicationService
  def call
    success! initialize!
  end

  private

  def initialize!
    initialize_schedules! rescue nil
    initialize_queues! rescue nil
    initialize_submit_loop! rescue nil
  end

  def initialize_schedules!
    exploits.each { |exploit| Engine::Exploit::AfterSave.call(exploit) }
  end

  def initialize_queues!
    Sidekiq::Queue.all.each(&:clear)
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
