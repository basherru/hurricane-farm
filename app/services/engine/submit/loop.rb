# frozen_string_literal: true

class Engine::Submit::Loop < ApplicationService
  delegate :submit_interval, to: :config

  def call
    success! loop!
  end

  private

  def loop!
    scheduler.every("#{submit_interval}s") { schedule_submit! }
  end

  def schedule_submit!
    SubmitJob.perform_later
  end

  def scheduler
    Rufus::Scheduler.singleton
  end
end
