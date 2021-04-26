class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.decimal :rating
      t.string :time_to_beat
    end
  end
end
