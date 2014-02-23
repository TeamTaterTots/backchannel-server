class ChangeChannelPlaceIdNotNull < ActiveRecord::Migration
  def change
    change_column_null :channels, :place_id, true
  end
end
