require 'recursive-open-struct'

module Decorators
  module Embeds
    class GeInfo
      attr_accessor :embed
      def initialize(item)
        # Get the item info and convert to openstruct for easy syntax later
        data = RecursiveOpenStruct.new(item.ge).item
        # Initialize new Embed object
        @embed = Discordrb::Webhooks::Embed.new
        @embed.title = data.name
        @embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: data.icon_large)
      end
    end
  end
end