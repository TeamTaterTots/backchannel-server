class Message < ActiveRecord::Base
  #belongs_to :channel

  class << self
    def backlog(channel_id, ts)
      @messages = Channel.find(channel_id).messages.where("ts>#{ts}")
      @messages.to_a #remove channel_id from response
    end
  end
end
