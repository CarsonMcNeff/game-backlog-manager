class AddReviewToUsersGames < ActiveRecord::Migration[5.2]
  def change
    add_column :users_games, :review, :string
  end
end
