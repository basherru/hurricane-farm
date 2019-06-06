class App
  extend Dry::Configurable

  setting :flag_format, eval(ENV.fetch('FLAG_FORMAT'))
end