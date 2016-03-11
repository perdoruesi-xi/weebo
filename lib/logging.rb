require 'logger'

module Weebo
  module Logging
    def logger
      ::Logger.new(STDERR)
    end
  end
end
