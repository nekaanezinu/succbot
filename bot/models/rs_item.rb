require 'logging'
require 'searchkick'
require 'require_all'
require_relative 'application_record'
require_relative '../config/rs3'
require_all 'decorators/embeds'


class RsItem < ApplicationRecord
  searchkick
  validates_uniqueness_of :name
  def ge
    uri = URI(RS3::GE_JSON + id.to_s)
    logger.info("Sending ge request to #{uri.to_s}")
    json = JSON.parse(Net::HTTP.get(uri))
  end

  def current_price
    uri = URI("http://services.runescape.com/m=itemdb_rs/api/graph/#{id}.json")
    json = JSON.parse(Net::HTTP.get(uri))
    json['daily'].values.last.to_i
  end

  def alch
    return high_alc if high_alc.present?
    high_alc = to_gold(Parsers::Wiki.new("https://runescape.wikia.com/api.php?action=parse&format=json&page=#{name}", 'High alch</a></th><td>', ' coins').call)
    save!
    high_alc
  end

  def logger
    Logging.logger('./log/log.log')
  end

  def self.logger
    Logging.logger('./log/log.log')
  end

  def to_gold(number)
    number.gsub(',', '').to_i
  end
end
