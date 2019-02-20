class AddNameEmailPaswordtoInstructor < ActiveRecord::Migration[5.1]
  def change
    add_column :instructors, :name, :string
    add_column :instructors, :email, :string
    add_column :instructors, :password, :string
    
    create_join_table :instructors, :sections do |t|
      t.index :instructor_id
      t.index :section_id
    end
  end
end
