class CreateCmsPartials < ActiveRecord::Migration
  def self.up
    create_table :cms_partials do |t|
      t.text :body
      t.string :path
      t.string :format
      t.string :locale
      t.string :handler

      t.timestamps
    end
  end

  def self.down
    drop_table :cms_partials
  end
end
