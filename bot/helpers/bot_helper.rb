require 'discordrb'

module BotHelper
    def self.parse_command(command, event)
        event.message.content.split(command).last
    end
end