require "sqlite3"

module Crawler
  class DB
    def initialize()
      @db = SQLite3::Database.open "crawler.db"
      @db.execute "CREATE TABLE IF NOT EXISTS products(Id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, price FLOAT, currency TEXT, description TEXT, extra TEXT)"
    end

    def close()
      @db.close
    end

    def saveProduct(name, price, currency, description, extraInformation)
      @db.execute "INSERT INTO products (name, price, currency, description, extra) values (?,?,?,?,?)", name, price, currency, description, extraInformation
    end

    def getProducts()
      results = @db.query "select * from products"
      puts results
    end
  end
end
