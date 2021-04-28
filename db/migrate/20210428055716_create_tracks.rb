class CreateTracks < ActiveRecord::Migration[6.1]
  def change
    create_table(:tracks, id: false) do |t|
      t.string :id
      t.string :name
      t.float :duration
      t.integer :times_played
      t.string :artist_id
      t.string :album_id
      t.string :artist
      t.string :album
      t.string :self

      t.timestamps
    end
  end
end
