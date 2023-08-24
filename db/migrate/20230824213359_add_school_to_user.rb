class AddSchoolToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :school_id, :integer
    add_foreign_key :users, :schools
  end
end
