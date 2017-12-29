require 'net/http'
require 'json'
module Parsers
  class Wiki
    attr_accessor :uri, :string_before, :string_after
    def initialize(link, string_before, string_after)
      @uri = URI(link)
      @string_before = string_before
      @string_after = string_after
    end

    def call
      response = Net::HTTP.get(uri)
      json = JSON.parse(response)
      text = json['parse']['text']['*']
      split = text.split(string_before)
      split[1].split(string_after)[0]
    end
  end
end
