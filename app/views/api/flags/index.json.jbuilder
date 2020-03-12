# frozen_string_literal: true

json.array! @flags, partial: "api/flags/flag", as: :flag
