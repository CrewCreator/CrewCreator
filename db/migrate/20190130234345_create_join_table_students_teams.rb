class CreateJoinTableStudentsTeams < ActiveRecord::Migration[5.1]
  def change
    create_join_table :students, :teams do |t|
      t.index :student_id
      t.index :team_id
    end
  end
end
