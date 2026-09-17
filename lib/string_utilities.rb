# frozen_string_literal: true

class StringUtilities
  def self.reverse(str)
    str.reverse
  end

  def self.uppercase(str)
    str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end

  def self.capitalize_words(str)
    str.split.map(&:capitalize).join(' ')
  end

  def self.remove_whitespace(str)
    str.gsub(/\s+/, '')
  end

  def self.count_words(str)
    str.split.length
  end

  def self.truncate(str, length)
    return str if str.length <= length

    "#{str[0, length]}..."
  end
end