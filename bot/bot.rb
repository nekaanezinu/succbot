require 'discordrb'
require_relative 'config/main'
require_all 'decorators/embeds'

bot = Discordrb::Commands::CommandBot.new token: Config.new.secrets.discord.token, prefix: '!'
# binding.pry
# bot.message(with_text: 'Ping!') do |event|
#   event.channel.send_embed('', RsItem.find(1077).ge_embed)
  
#   binding.pry
#   event.respond 'Pong!'
# end

bot.command :ge do |event|
  binding.pry
  event.channel.send_embed('This is what I found: ', RsItem.find_from_name(event.message.content.split('!ge ').last).ge_embed)
  event.respond 'Pong!'
end

bot.run
