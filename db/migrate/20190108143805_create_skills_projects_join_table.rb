class CreateSkillsProjectsJoinTable < ActiveRecord::Migration[5.1]
  def change
    create_join_table :skills, :projects do |t|
      t.index :skill_id
      t.index :project_id
    end
  end
end
