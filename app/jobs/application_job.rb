# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  discard_on Exception
end
