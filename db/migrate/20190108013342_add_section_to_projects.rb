class AddSectionToProjects < ActiveRecord::Migration[5.1]
  def change
    add_reference :projects, :section
  end
end
