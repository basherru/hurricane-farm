# frozen_string_literal: true

module Utils
  extend self

  def to_local_delimiter(content)
    content.gsub("\r\n", "\n")
  end

  def with_numeric_status(params)
    params.map { |k, v| [k, k == :status ? to_numeric(v) : v] }.to_h
  end

  private

  def to_numeric(status)
    status == "up" ? 1 : 0
  end
end
