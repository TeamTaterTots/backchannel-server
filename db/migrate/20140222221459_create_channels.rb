class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.string :place_id
      t.string :name

      t.timestamps
    end
  end
end
