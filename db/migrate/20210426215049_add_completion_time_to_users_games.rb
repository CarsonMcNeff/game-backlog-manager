class AddCompletionTimeToUsersGames < ActiveRecord::Migration[5.2]
  def change
    add_column :users_games, :completion_time, :integer
  end
end
