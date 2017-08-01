class CreatePayloaderEvents < ActiveRecord::Migration
  def change
    create_table :payloader_events do |t|
      t.string :uuid, null: false, unique: true
      t.string :http_method, null: false
      t.string :url, null: false
      t.string :signature, null: false
      t.text :body, limit: 4294967295
      t.integer :retry_count, null: false, default: 0
      t.string :job_id
      t.datetime :first_run_at
      t.datetime :next_run_at
      t.datetime :failed_at

      t.timestamps null: false
    end
  end
end
