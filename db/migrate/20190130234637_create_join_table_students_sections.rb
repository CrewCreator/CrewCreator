class CreateJoinTableStudentsSections < ActiveRecord::Migration[5.1]
  def change
    create_join_table :students, :sections do |t|
      t.index :student_id
      t.index :section_id
    end
  end
end
