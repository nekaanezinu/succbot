require 'logging'
require './helpers/bot_helper'

module Embeds
  class Base
 
    private

    def thumb(icon)
      # Create thumbnail for embeds object from icon's url
      Discordrb::Webhooks::EmbedThumbnail.new(url: icon)
    end

    def logger
      Logging.logger('./log/log.log')
    end

    def parsed_name(command, event)
      BotHelper.parse_command(command, event)
    end

    def color_code(color)
      case color
      when 'red'
        [193, 0, 0]
      when 'orange'
        [255, 148, 0]
      when 'green'
        [0, 158, 21]
      end
    end
  end
end