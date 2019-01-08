class AddSectionsAssociationToCourse < ActiveRecord::Migration[5.1]
  def self.up
    add_column :sections, :course_id, :integer
    add_index 'sections', ['course_id'], :name => 'section_course_id' 
  end

  def self.down
    remove_column :sections, :course_id
  end
end
