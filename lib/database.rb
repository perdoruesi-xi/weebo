require "sqlite3"

module Weebo
  class Database
    attr_reader :db

    COLUMN_NAMES = ["sabahu", "dreka", "ikindia", "akshami", "jacia"]

    def initialize(db)
      @db = db
    end

    def load_data
      columns.select { |key, _| COLUMN_NAMES.include?(key) }
    end

    def columns(date = Time.now.strftime("%d-%m-%Y"))
      rows = exec_query("SELECT * FROM kosova WHERE data='#{date}'")
      rows.flatten[0]
    end

    def exec_query(sql)
      if file_exists?(db)
        sqlite3_connection.execute(sql)
      else
        fail "database #{db} does not exist"
      end
    end

    def file_exists?(local_fname)
      File.exist?(local_fname)
    end

    private

    def sqlite3_connection
      @sqlite3_connection ||= SQLite3::Database.new(
         db.to_s,
         :results_as_hash => true
       )
    end
  end
end
