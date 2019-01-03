class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :course
      t.integer :number
      t.text :projects
      t.string :moderators
      t.string :admin
      t.text :students

      t.timestamps
    end
  end
end
