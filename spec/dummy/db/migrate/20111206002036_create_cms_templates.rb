class CreateCmsTemplates < ActiveRecord::Migration
  def self.up
    create_table :cms_templates do |t|
      # t.references :cms_layout
      t.string :title
      t.string :meta_description
      t.string :path
      t.string :format
      t.string :locale
      t.string :handler
      t.text :body
      
      t.timestamps
    end
  end

  def self.down
    drop_table :cms_templates
  end
end
