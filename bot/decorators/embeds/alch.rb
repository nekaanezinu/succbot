require 'recursive-open-struct'
require 'thread'
require 'concurrent'
module Embeds
  class Alch < Embeds::Base

    attr_accessor :embed, :command, :event
    def initialize(event)
      @command = '!alch'
      @event = event
      @embed = Discordrb::Webhooks::Embed.new
      @nature_rune = RsItem.search('Nature rune', fields: [:name]).first
      @fire_rune = RsItem.search('Fire rune', fields: [:name]).first
    end

    def call
      @item = RsItem.search(parsed_name(command, event.message.content), fields: [:name]).first

      async_ge_item = Concurrent::Promise.execute{ find_ge_item }
      async_item_price = Concurrent::Promise.execute{ find_item_current_price }
      async_nature_price = Concurrent::Promise.execute{ find_nature_rune_current_price }
      async_fire_price = Concurrent::Promise.execute{ find_fire_rune_current_price }

      while async_ge_item.pending? && async_item_price.pending? && async_nature_price.pending? && async_fire_price.pending?
        sleep(0.1)
      end

      @without_staff = @item.alch - (@item_current_price + @nature_rune_current_price + @fire_rune_current_price * 5)
      @with_staff = @item.alch - (@item_current_price + @nature_rune_current_price)

      embed.title = @ge_item.name
      embed.thumbnail = thumb(@ge_item.icon_large)
      embed.url = URI("http://runescape.wikia.com/wiki/#{@ge_item.name.gsub(' ','')}").to_s
      embed.color = if @without_staff > 0
                      color_code('green')
                    elsif @with_staff > 0
                      color_code('orange')
                    else
                      color_code('red')
                    end
      add_fields
      embed
    end

    private

    def add_fields
      embed.add_field(name: 'Current price', value: @item_current_price.to_s, inline: true)
      embed.add_field(name: 'High alch', value: @item.alch.to_s, inline: true)
      embed.add_field(name: 'Profit without fire staff', value: @without_staff.to_s, inline: true)
      embed.add_field(name: 'Profit with fire staff', value: @with_staff.to_s, inline: true)
    end

    def find_ge_item
      @ge_item = RecursiveOpenStruct.new(@item.ge).item
    end

    def find_item_current_price
      @item_current_price = @item.current_price
    end

    def find_nature_rune_current_price
      @nature_rune_current_price = @nature_rune.current_price
    end

    def find_fire_rune_current_price
      @fire_rune_current_price = @fire_rune.current_price
    end


  end
end