class Channel < ActiveRecord::Base
  #has_many: :participants
  class << self
    def find_nearby(place_id)
      channels=Channel.find(:all, :conditions => { :place_id => place_id })
    end
  end

  def create
  end
  def kill
  end
  def join
  end
  def count_participants
  end
  def list_participants
  end
end
