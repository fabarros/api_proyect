class CreateArtists < ActiveRecord::Migration[6.1]
  def change
    create_table(:artists, id: false) do |t|

      t.string :id
      t.string :name
      t.integer :age
      t.string :albums
      t.string :tracks
      t.string :self

      t.timestamps
    end
  end
end
