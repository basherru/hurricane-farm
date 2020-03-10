module Scheduler
  extend ActiveSupport::Concern

  def schedule
    return if down?
    unschedule
    scheduler = Rufus::Scheduler.singleton
    scheduler_handle = scheduler.every("#{period}s") do
      teams.each do |team|
        ExploitJob.perform_later(team.id, id)
      end
    end
    update_columns(scheduler_handle: scheduler_handle)
  end

  def unschedule
    return if scheduler_handle.nil?
    scheduler = Rufus::Scheduler.singleton
    job = scheduler.job(scheduler_handle)
    job&.unschedule
    job&.kill
    update_columns(scheduler_handle: nil)
  end

  alias :reschedule :schedule
end