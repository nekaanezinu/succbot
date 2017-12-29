require 'discordrb'
require_all './decorators/embeds'

module Senders
  class Embed
    attr_accessor :event, :embed_class
    def initialize(event, embed_class)
      @event = event
      @embed_class = embed_class
    end

    def send
      begin
        event.channel.send_embed('', embed_class.new(event).call)
      rescue
        event.respond 'I could not find that item 🤔'
      end
    end
  end
end