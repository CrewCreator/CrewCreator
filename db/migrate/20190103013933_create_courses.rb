class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string 'name'
      t.string 'code'
      t.text 'description'
      t.timestamps
    end
  end
end
