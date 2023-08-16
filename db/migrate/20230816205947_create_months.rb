class CreateMonths < ActiveRecord::Migration[7.0]
  def change
    create_table :months do |t|
      t.string :name
      t.boolean :paid
      t.references :student, null: false, foreign_key: true
      t.references :school_year, null: false, foreign_key: true

      t.timestamps
    end
  end
end
