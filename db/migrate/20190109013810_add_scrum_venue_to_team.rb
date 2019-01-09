class AddScrumVenueToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :skills, :scrum_venue, :string
  end
end
