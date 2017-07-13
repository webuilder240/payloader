class CreatePayloaderSiteUrls < ActiveRecord::Migration
  def change
    create_table :payloader_site_urls do |t|
      t.integer :site_id, null: false
      t.string :uuid, null: false
      t.string :url, null: false
      t.boolean :livemode, null: false, default: false

      t.timestamps null: false
    end
  end
end
