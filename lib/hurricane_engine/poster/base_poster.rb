module HurricaneEngine
  module Poster
    class BasePoster
      class << self
        def post(flag)
          endpoint       = ENV.fetch("FARM_SERVER_IP")
          port           = ENV.fetch("FARM_SERVER_PORT")
          raw_payload    = flag.to_json(only: %i[content exploit_id team_id])
          socket         = Socketry::TCP::Socket.connect(endpoint, port)
          http_request   = http_post_payload(raw_payload, endpoint, port)
          puts http_request
          socket.write(http_request)
          socket.close
        end

        private

        def http_post_payload(raw_payload, endpoint, port)
          options = {
            path: Rails.application.routes.url_helpers.api_flags_path,
            api_key: ENV.fetch("API_KEY"),
            endpoint: endpoint,
            port: port,
            content_length: raw_payload.length,
            raw_payload: raw_payload
          }
          post_template(options)
        end

        def post_template(options)
          <<-POST.gsub(/^\s+\|/, '')
            |POST #{options.fetch(:path)} HTTP/1.1
            |Content-Type: application/json
            |API_KEY: #{options.fetch(:api_key)}
            |Connection: close
            |Host: #{options.fetch(:endpoint)}:#{options.fetch(:port)}
            |Content-Length: #{options.fetch(:content_length)}
            |
            |#{options.fetch(:raw_payload)}
          POST
        end
      end
    end
  end
end