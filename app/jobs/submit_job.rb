# frozen_string_literal: true

class SubmitJob < ApplicationJob
  queue_as :submits

  def perform
    Engine::Submit::Process.call
  end
end
