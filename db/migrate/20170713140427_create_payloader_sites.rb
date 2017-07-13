class CreatePayloaderSites < ActiveRecord::Migration
  def change
    create_table :payloader_sites do |t|
      t.string :uuid, null: false
      t.string :name, null: false
      t.string :signature, null: false

      t.timestamps null: false
    end
  end
end
