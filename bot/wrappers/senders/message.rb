require 'discordrb'
require_all './decorators/messages'

module Senders
  class Message
    attr_accessor :event, :message_class
    def initialize(event, message_class)
      @event = event
      @message_class = message_class
    end

    def send
      begin
        event.respond(message_class.new(event).call)
      rescue
        event.respond 'I did not find that item 🤔'
      end
    end
  end
end