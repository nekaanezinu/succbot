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

  def logger
    Logging.logger('./log/log.log')
  end

  def self.logger
    Logging.logger('./log/log.log')
  end
end
