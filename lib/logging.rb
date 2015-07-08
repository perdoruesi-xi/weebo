require 'logger'

module Weebo
  module Logging
    def logger
      logger = ::Logger.new(STDERR)

      return logger
    end
  end
end