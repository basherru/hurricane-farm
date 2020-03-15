# frozen_string_literal: true

class Engine::Reset < ApplicationService
  def call
    success! reset!
  end

  private

  def reset!
    reset_schedules!
    reset_queues!
  end

  def reset_schedules!
    exploits.each { |exploit| Engine::Exploit::AfterSave.call(exploit) }
  end

  def reset_queues!
    queues.map(&:new).each(&:clear)
  end

  def exploits
    ::Exploit.all
  end

  def queues
    [Sidekiq::RetrySet, Sidekiq::ScheduledSet, Sidekiq::DeadSet]
  end
end
