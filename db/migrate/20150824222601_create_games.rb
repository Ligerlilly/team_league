class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.column :home_team_id, :integer
      t.column :away_team_id, :integer
      t.column :home_team_score, :integer
      t.column :away_team_score, :integer
      t.column :winning_team_id, :integer
    end
  end
end
