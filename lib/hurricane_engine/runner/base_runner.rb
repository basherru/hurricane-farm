module HurricaneEngine
  module Runner
    class BaseRunner
      class << self
        def run(team, exploit)
          raise NotImplementedError.new
        end
      end
    end
  end
end