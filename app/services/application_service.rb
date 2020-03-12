# frozen_string_literal: true

class ApplicationService < Polist::Service
  include Polist::Struct
  include Polist::Builder
  include Memery

  delegate :config, to: App
  delegate :logger, to: Rails
end
