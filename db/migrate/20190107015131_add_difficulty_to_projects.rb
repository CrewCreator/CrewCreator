class AddDifficultyToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :difficulty, :integer
  end
end
