require 'sqlite3'

module Weebo
  class Connection
    def start_new
      data = []
      data.push Weebo::Connection.collect_all
      columns = data.flatten

      unless columns.nil?
        return columns[0].select { |k, v| ['sabahu', 'dreka', 'ikindia', 'akshami', 'jacia'].include?(k) }
      end
    end

    def self.collect_all
      begin
        db = SQLite3::Database.new "db/takvimi.sqlite3"
        db.results_as_hash = true
        date = Time.now.strftime("%d-%m-%Y")

        query = db.execute "SELECT * FROM kosova WHERE data='#{date}'"
      rescue SQLite3::Exception => e
        puts "Exception occurred"
        puts e
      ensure
        db.close if db
      end
    end
  end
end
