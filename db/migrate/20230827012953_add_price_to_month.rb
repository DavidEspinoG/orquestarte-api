class AddPriceToMonth < ActiveRecord::Migration[7.0]
  def change
    add_column :months, :price, :integer
  end
end
