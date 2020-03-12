# frozen_string_literal: true

json.array! @teams, partial: "api/teams/team", as: :team
