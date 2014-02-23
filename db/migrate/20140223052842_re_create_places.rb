class ReCreatePlaces < ActiveRecord::Migration
  def up
    create_table :places, {:id => false} do |t|
      t.string :foursquare_venue_id
    end
    execute "ALTER TABLE places ADD PRIMARY KEY (foursquare_venue_id);"
  end
  def down
    drop_table :places
  end
end
