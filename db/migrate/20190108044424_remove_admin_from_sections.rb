class RemoveAdminFromSections < ActiveRecord::Migration[5.1]
  def change
    remove_reference :sections, :admin, foreign_key: true
  end
end
