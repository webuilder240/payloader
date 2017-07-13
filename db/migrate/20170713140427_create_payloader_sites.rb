class CreatePayloaderSites < ActiveRecord::Migration
  def change
    create_table :payloader_sites do |t|
      t.string :uuid
      t.string :name
      t.string :signature

      t.timestamps null: false
    end
  end
end
