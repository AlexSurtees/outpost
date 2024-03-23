class CreateGames < ActiveRecord::Migration[7.1]
  def change
    create_table :games do |t|
      t.string :game_id
      t.string :pgn

      t.timestamps
    end
  end
end
