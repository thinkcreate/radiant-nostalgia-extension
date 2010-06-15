class CreateNotFoundRequests < ActiveRecord::Migration
  def self.up
    create_table :not_found_requests, :force => true do |t|
      t.string  :url, :limit => 255, :unique => true
      t.string  :referrer, :limit => 255, :unique => true
      t.integer :count_created, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :not_found_requests
  end
end
