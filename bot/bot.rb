require 'discordrb'
require_relative 'config/main'
require_all 'decorators/embeds'

bot = Discordrb::Bot.new token: Config.new.secrets.discord.token

bot.message(with_text: 'Ping!') do |event|
  
  event.respond 'Pong!'
end

bot.run
