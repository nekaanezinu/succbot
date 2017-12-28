require 'discordrb'
require_relative './config/main'
require_relative './wrappers/senders/embed'
require_all 'decorators/embeds'
bot = Discordrb::Commands::CommandBot.new(token: Config.new.secrets.discord.token, prefix: '!')

bot.command :ge do |event|
  Senders::Embed.new(event, '', Embeds::GeInfo, '!ge').send
end

bot.run
