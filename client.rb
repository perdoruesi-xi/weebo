require_relative "weebo"
require_relative "lib/bot"
puts Weebo::VERSION

require_relative "lib/wsample"
puts "Weebo Bot"

# Weebo Bot
weebo = Weebo::Bot.new
weebo.perform

# Build your own add-ons 
#  weebo = Weebo::Bot.new
#  weebo.scheduler(:every, frequency:, '5h') do 
#  	https://your_team_name.slack.com/services/new/incoming-webhook
#    Add a new Incoming WebHooks integration with your account credentials.
#    Weebo::Slacky.new('hook','channel', 'username').say(text)
#  end