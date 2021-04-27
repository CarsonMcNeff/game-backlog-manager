class CreateUsersGames < ActiveRecord::Migration[5.2]
  def change
    create_table :users_games do |t|
      t.integer :user_id
      t.integer :game_id
      t.string :notes
      t.boolean :completed
      t.integer :personal_rating
    end
  end
end
