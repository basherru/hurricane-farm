module HurricaneEngine
  module Poster
    class BasePoster
      class << self
        def post(flag)
          raise NotImplementedError.new
        end
      end
    end
  end
end