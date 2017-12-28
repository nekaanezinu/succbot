require_relative 'application_record'
require_relative '../config/rs3'
class RsItem < ApplicationRecord
  def ge
    uri = URI(RS3::GE_JSON + id.to_s)
    json = JSON.parse(Net::HTTP.get(uri))
  end
end
