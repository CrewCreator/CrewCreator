class AddDetailsToSections < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :semester, :string
    add_column :sections, :year, :integer
  end
end
