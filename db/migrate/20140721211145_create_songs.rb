class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :url
      t.string :thumbnails, array: true
      t.string :embed_url
      t.string :uid

      t.timestamps
    end
  end
end
