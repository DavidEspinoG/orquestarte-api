class RemoveInscriptionDateFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :inscription_date
  end
end
