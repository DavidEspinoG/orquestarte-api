class CreateSchoolYears < ActiveRecord::Migration[7.0]
  def change
    create_table :school_years do |t|
      t.date :start_date
      t.date :end_date
      t.string :name

      t.timestamps
    end
  end
end
