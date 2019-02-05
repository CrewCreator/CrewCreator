class CreateJoinTableSectionsEmails < ActiveRecord::Migration[5.1]
  def change
    create_join_table :sections, :emails do |t|
      t.index :section_id
      t.index :email_id
    end
  end
end
