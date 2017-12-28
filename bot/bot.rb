require 'discordrb'
require_relative 'config/main'
require_all 'decorators/embeds'

bot = Discordrb::Bot.new token: Config.new.secrets.discord.token

bot.message(with_text: 'Ping!') do |event|
  event.channel.send_embed('', RsItem.find(1077).ge_embed)
  binding.pry
  event.respond 'Pong!'
end

bot.run
