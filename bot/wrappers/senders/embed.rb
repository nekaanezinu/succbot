require 'discordrb'
require_all './decorators/embeds'

module Senders
  class Embed
    attr_accessor :event, :message, :embed_class, :command
    def initialize(event, message, embed_class, command)
      @event = event
      @message = message
      @embed_class = embed_class
      @command = command
    end

    def send
      begin
        event.channel.send_embed(message, embed_class.new(command, event).call)
      rescue
        event.respond 'I did not find that item 🤔'
      end
    end
  end
end