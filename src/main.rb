#!/usr/bin/ruby

require "slack-ruby-bot"

require_relative "commands.rb"

class FuukaBot < SlackRubyBot::Bot
  command("mabufu") do |client, data, match|
    client.say(text: "Bufula! :snowflake:", channel: data.channel)
  end

  get_commands.each do |cmd|
    command(cmd[:command]) do |client, data, match|
      match["command"] =~ cmd[:command]
      args = $~
      cmd[:response].call(client, data, args)
    end
  end
end

FuukaBot.run
