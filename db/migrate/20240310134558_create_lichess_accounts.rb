class CreateLichessAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :lichess_accounts do |t|
      t.belongs_to :user, foreign_key: true
      t.string :token
      t.string :user
      t.string :username

      t.timestamps
    end
  end
end
