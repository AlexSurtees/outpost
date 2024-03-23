class RemoveFieldNameFromTableName < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :game_id, :string
  end
end
