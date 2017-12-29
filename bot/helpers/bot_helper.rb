require 'discordrb'

module BotHelper
    def self.parse_command(command, message)
        message.split(command).last
    end
end