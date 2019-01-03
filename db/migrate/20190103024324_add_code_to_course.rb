class AddCodeToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :code, :string
  end
end
