class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.text :site_url, null: false
      t.string :site_type
      t.text :title
      t.text :description
      t.string :site_name
      t.text :image

      t.timestamps
    end
  end
end
