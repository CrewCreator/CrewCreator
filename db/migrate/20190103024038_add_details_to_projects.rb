class AddDetailsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :name, :string
    add_column :projects, :description, :text
    add_column :projects, :students_rated, :integer
    add_column :projects, :total_interest, :integer
  end
end
