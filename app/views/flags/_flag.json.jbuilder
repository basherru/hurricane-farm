# frozen_string_literal: true

json.extract! flag, :id, :created_at, :updated_at
json.url flag_url(flag, format: :json)
