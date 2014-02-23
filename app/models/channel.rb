class Channel < ActiveRecord::Base
  belongs_to :place
  #has_many: :participants
  validates_presence_of :place_id

  class << self
    def find_nearby(place_id)
      channels=Channel.find(:all, :conditions => { :place_id => place_id })
    end
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
