require 'rufus-scheduler'
require_relative "../lib/adapter"
require_relative "../lib/adapters/slack"

module Weebo
  class Bot
    def perform
      call(cron)
    end

    # .---------------- minute (0 - 59)
    # |  .------------- hour (0 - 23)
    # |  |  .---------- day of month (1 - 31)
    # |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
    # |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
    # |  |  |  |  |
    # 0  0  *  *  *
    def cron
      scheduler(:cron, frequency: '0 0 * * *') do
        begin
          puts "#{Time.new.strftime("%m/%d/%Y")}"
          data = Weebo::Connection.new.start_new
          run.job(process(data))
        rescue Rufus::Scheduler::TimeoutError => exception
          logger.error "Exception: #{exception.message}"
        end
      end
    end

    def process(data)
      jobs ||= []
      data.each do |perform, period|
        text, time = format(perform, period)
        job_id = scheduler(:in, frequency: time) do
          begin
            # Add a new Incoming WebHooks integration with your account credentials.
            # https://your_team_name.slack.com/services/new/incoming-webhook
            Weebo::Slacky.new('hook','channel', 'username').say(text)  
          rescue SocketError => exception
            logger.fatal "#{exception}"  
          end
        end
        jobs.push(job_id)
      end
      jobs
    end

    def format(perform, period)
      format_perform_txt =
          case perform
            when "sabahu"
              "sabahut"
            when "dreka"
              "drekës"
            when "ikindia"
              "ikindisë"
            when "akshami"
              "akshamit"
            when "jacia"
              "jacisë"
          end
      text = "Koha e namazit të #{format_perform_txt}".encode!('utf-8')
      time = "#{Time.now.strftime("%Y-%m-%d")} #{period}:00"

      return text, time
    end

    def scheduler(duration, frequency:, &block)
      fail "Symbol expected, got #{duration.class}" unless duration.is_a?(Symbol)

      job_id = run.method(duration).call frequency do
        if block_given?
          yield
        else
          raise ArgumentError, "block not given" unless block_given?
        end
      end
    end

    def run
      Rufus::Scheduler.new
    end

    def call(job)
      run.job(job)
      run.join
    end
  end
end