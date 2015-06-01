require_relative "weebo"
require_relative "lib/bot"
require_relative "lib/wsample"
require_relative "lib/adapter"

Dir['lib/adapters/*.rb'].each {|file| require_relative file }

# Weebo Bot
weebo = Weebo::Bot.new
weebo.perform
