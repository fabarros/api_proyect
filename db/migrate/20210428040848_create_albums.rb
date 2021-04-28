class CreateAlbums < ActiveRecord::Migration[6.1]
  def change
    create_table(:albums, id: false) do |t|
      t.string :id
      t.string :name
      t.string :genre
      t.string :artist_id
      t.string :artist
      t.string :tracks
      t.string :self

      t.timestamps
    end
  end
end
