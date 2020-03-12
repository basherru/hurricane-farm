# frozen_string_literal: true

class App
  extend Dry::Configurable

  setting :flag_format, eval(ENV.fetch("FLAG_FORMAT"))
  setting :datatable_rating_size, ENV.fetch("DATATABLE_RATING_SIZE").to_i
end
