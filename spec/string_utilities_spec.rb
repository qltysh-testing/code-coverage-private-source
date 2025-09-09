# frozen_string_literal: true

require_relative '../lib/string_utilities'

RSpec.describe StringUtilities do
  describe ".reverse" do
    it "reverses a string" do
      expect(StringUtilities.reverse("hello")).to eq("olleh")
      expect(StringUtilities.reverse("ruby")).to eq("ybur")
    end
  end

  describe ".uppercase" do
    it "converts string to uppercase" do
      expect(StringUtilities.uppercase("hello")).to eq("HELLO")
      expect(StringUtilities.uppercase("Ruby")).to eq("RUBY")
    end
  end

  describe ".lowercase" do
    it "converts string to lowercase" do
      expect(StringUtilities.lowercase("HELLO")).to eq("hello")
      expect(StringUtilities.lowercase("RuBy")).to eq("ruby")
    end
  end

  describe ".capitalize_words" do
    it "capitalizes each word in a string" do
      expect(StringUtilities.capitalize_words("hello world")).to eq("Hello World")
      expect(StringUtilities.capitalize_words("ruby on rails")).to eq("Ruby On Rails")
    end
  end

  describe ".remove_whitespace" do
    it "removes all whitespace from string" do
      expect(StringUtilities.remove_whitespace("hello world")).to eq("helloworld")
      expect(StringUtilities.remove_whitespace("  ruby  on  rails  ")).to eq("rubyonrails")
    end
  end

  describe ".count_words" do
    it "counts words in a string" do
      expect(StringUtilities.count_words("hello world")).to eq(2)
      expect(StringUtilities.count_words("ruby on rails is awesome")).to eq(5)
    end
  end
end