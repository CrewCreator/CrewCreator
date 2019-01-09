class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.integer :defined_id
      t.string :name
      t.string :description
      t.datetime :scrum_time
      t.string :version_control_link
      t.string :staging_link
      t.string :string
      t.string :production_link
      t.string :project_management_link

      t.timestamps
    end
  end
end
