require 'recursive-open-struct'
require 'logging'
require './helpers/bot_helper'

module Embeds
  class GeInfo
    attr_accessor :embed, :command, :event
    def initialize(command, event)
      @command = command
      @event = event
      @embed = Discordrb::Webhooks::Embed.new
    end

    def call
      # Find correct item from the db
      item = RsItem.search(parsed_name, fields: [:name]).first
      raise "Item #{parsed_name} not found" unless item.present?

      logger.info("Found item id #{item.id} and name #{item.name}")
      # Get the item info and convert to openstruct for easy syntax later
      data = RecursiveOpenStruct.new(item.ge).item
      # Initialize new Embed object
      embed.title = data.name
      embed.thumbnail = thumb(data.icon_large)
      embed
    end

    def thumb(icon)
      # Create thumbnail for embeds object from icon's url
      Discordrb::Webhooks::EmbedThumbnail.new(url: icon)
    end

    def logger
      Logging.logger('./log/log.log')
    end

    private

    def parsed_name
      BotHelper.parse_command(command, event)
    end
  end
end
