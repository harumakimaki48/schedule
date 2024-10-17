class HomeController < ApplicationController
  def index
    begin
      # PostgreSQLに接続できるかテスト
      ActiveRecord::Base.connection.execute("SELECT 1")
      @db_status = "データベースに正常に接続されています"
    rescue => e
      @db_status = "データベースに接続できません: #{e.message}"
    end
  end
end
