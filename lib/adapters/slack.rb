require 'slack-notifier'

module Weebo
  class Slacky
    def initialize(hook, channel, username)
      @slack ||= Slack::Notifier.new hook, channel: channel, username: username
    end

    def say(text, color="#3498db")
      message = {
          fallback: "#{text}",
          text: "#{text}",
          color: "#{color}"
      }
      @slack.ping '', attachments: [message]
    end
  end
end
