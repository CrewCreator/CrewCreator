class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.belongs_to :project
      t.string :name
      t.string :version_control_link
      t.string :production_link
      t.string :management_link
      t.string :scrum_location
      t.datetime :scrum_time

      t.timestamps
    end
  end
end
