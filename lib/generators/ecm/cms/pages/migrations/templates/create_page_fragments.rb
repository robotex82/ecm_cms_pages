class CreatePageFragments < ActiveRecord::Migration
  def self.up
    create_table :page_fragments do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :page_fragments
  end
end
