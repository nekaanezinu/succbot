require 'recursive-open-struct'

module Embeds
  class GeInfo < Embeds::Base
    attr_accessor :embed, :command, :event
    def initialize(event)
      @command = '!ge'
      @event = event
      @embed = Discordrb::Webhooks::Embed.new
    end

    def call
      # Find correct item from the db
      item = RsItem.search(parsed_name(command, event.message.content), fields: [:name]).first
      raise "Item #{parsed_name} not found" unless item.present?
      
      logger.info("Found item id #{item.id} and name #{item.name}")
      # Get the item info and convert to openstruct for easy syntax later
      data = RecursiveOpenStruct.new(item.ge).item
      # Initialize new Embed object
      embed.title = data.name
      embed.thumbnail = thumb(data.icon_large)
      embed
    end
  end
end
