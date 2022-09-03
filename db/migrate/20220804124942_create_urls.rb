class CreateUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :urls do |t|
      t.text :site_url, null: false
      t.string :site_type
      t.text :site_title
      t.text :site_description
      t.string :site_name
      t.text :site_image
      t.text :site_image_alt

      t.timestamps
    end
  end
end
