class AddColumnsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :name, :string
    add_column :places, :icon, :text
    add_column :places, :distance, :decimal, precision: 10, scale: 1
  end
end
