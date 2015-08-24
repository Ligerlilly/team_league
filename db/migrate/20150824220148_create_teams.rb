class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.column :name, :string

      t.timestamps
    end
  end
end
