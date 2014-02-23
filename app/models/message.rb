class Message < ActiveRecord::Base
  belongs_to :channel

  def self.created_after(time)
    where("created_at > ?", time)
  end
end
