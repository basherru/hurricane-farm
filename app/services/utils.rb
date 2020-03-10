module Utils
  extend self

  def to_local_delimiter(content)
    content.gsub("\r\n", "\n")
  end
end