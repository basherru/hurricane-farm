# frozen_string_literal: true

class ApplicationService < Polist::Service
  include Polist::Struct
  include Polist::Builder
  include Memery

  class << self
    delegate :config, to: App
  end

  delegate :logger, to: Rails
  delegate :config, to: :class
end
