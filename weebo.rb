require 'active_support/all'
require 'rufus-scheduler'
require 'yaml'
require 'logger'

module Weebo
  extend ActiveSupport::Autoload

  autoload :Adapter,  './lib/adapter'
  autoload :Bot,      './lib/bot'
  autoload :Database, './lib/database'
  autoload :Logging,  './lib/logging'
  autoload :Util,     './lib/util'
end
