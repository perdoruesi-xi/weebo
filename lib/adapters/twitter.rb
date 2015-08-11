require 'twitter'

module Weebo
  class Twitter
    def initialize(params)
      @twitter ||= ::Twitter::REST::Client.new

      @twitter.consumer_key        = params[:consumer_key]
      @twitter.consumer_secret     = params[:consumer_secret]
      @twitter.access_token        = params[:access_token]
      @twitter.access_token_secret = params[:access_token_secret]
    end

    def say(text, color="#3498db")
      @twitter.update(text)
    end
  end
end
