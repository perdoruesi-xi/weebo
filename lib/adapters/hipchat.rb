require 'hipchat'

module Weebo
  class Hipchat
    def initialize(params)
      @hipchat ||= ::HipChat::Client.new(params[:api_token], :api_version => 'v2')
      @room      = params[:room]
      @username  = params[:username]
    end

    def say(text, color="red")
      @hipchat[@room].send(@username, text, :notify => true, :color => color) 
    end
  end
end
