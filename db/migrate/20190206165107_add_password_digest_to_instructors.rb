class AddPasswordDigestToInstructors < ActiveRecord::Migration[5.1]
  def change
    add_column :instructors, :password_digest, :string
  end
end
