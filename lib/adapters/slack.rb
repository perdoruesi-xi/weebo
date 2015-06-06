require 'slack-notifier'

module Weebo
  class Slack
    def initialize(params)
      @slack ||= ::Slack::Notifier.new params[:hook]

      @slack.channel = params[:channel]
      @slack.username = params[:username]
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
