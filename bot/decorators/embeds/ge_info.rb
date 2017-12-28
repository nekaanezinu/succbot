require 'recursive-open-struct'
require 'logging'
require './helpers/bot_helper'

module Embeds
  class GeInfo
    attr_accessor :embed
    def initialize(command, event)
      # Find correct item from the db
      item = RsItem.search(BotHelper.parse_command(command, event), fields: [:name]).first
      logger.info("Found item id #{item.id} and name #{item.name}")
      # Get the item info and convert to openstruct for easy syntax later
      data = RecursiveOpenStruct.new(item.ge).item
      # Initialize new Embed object
      @embed = Discordrb::Webhooks::Embed.new
      @embed.title = data.name
      @embed.thumbnail = thumb(data.icon_large)
    end

    def thumb(icon)
      # Create thumbnail for embeds object from icon's url
      Discordrb::Webhooks::EmbedThumbnail.new(url: icon)
    end

    def logger
      Logging.logger('./log/log.log')
    end
  end
end
