class CreatePayloaderEvents < ActiveRecord::Migration
  def change
    create_table :payloader_events do |t|
      t.integer :site_id, null: false
      t.integer :site_url_id, null: false
      t.string :post_url, null: false
      t.string :uuid, null: false
      t.string :event_type, null: false
      t.text :body, limit: 4294967295
      t.integer :retry_count, null: false, default: 0
      t.datetime :first_run_at
      t.datetime :next_run_at
      t.datetime :failed_at

      t.timestamps null: false
    end
  end
end
