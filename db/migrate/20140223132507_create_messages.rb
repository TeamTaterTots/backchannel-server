class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :channel_id
      t.string :nick
      t.string :text

      t.timestamps
    end
  end
end
