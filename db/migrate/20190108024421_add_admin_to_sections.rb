class AddAdminToSections < ActiveRecord::Migration[5.1]
  def change
    add_reference :sections, :admin
  end
end
