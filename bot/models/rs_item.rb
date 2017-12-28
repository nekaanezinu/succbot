require_relative 'application_record'
require_relative '../config/rs3'
require_all 'decorators/embeds'

class RsItem < ApplicationRecord
  def ge
    uri = URI(RS3::GE_JSON + id.to_s)
    json = JSON.parse(Net::HTTP.get(uri))
  end

  def ge_embed
    Decorators::Embeds::GeInfo.new(self).embed
  end
end
