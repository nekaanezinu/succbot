require 'discordrb'
require_relative './config/main'
require_all './wrappers/senders'
require_all './decorators'
bot = Discordrb::Commands::CommandBot.new(token: Config.new.secrets.discord.token, prefix: '!')

bot.command :ge, description: 'Finds an item from Grand Exchange' do |event|
  Senders::Embed.new(event, Embeds::GeInfo).send
end

bot.command :alch, description: 'Returns profit from alching an item' do |event|
  Senders::Embed.new(event, Embeds::Alch).send
end

bot.run
