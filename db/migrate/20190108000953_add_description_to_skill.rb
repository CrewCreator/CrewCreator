class AddDescriptionToSkill < ActiveRecord::Migration[5.1]
  def change
    add_column :skills, :description, :string
  end
end
