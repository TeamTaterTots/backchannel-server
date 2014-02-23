class PlaceSerializer < ActiveModel::Serializer
  attributes :icon, :id, :name, :distance
  has_many :channels

  def icon
    JSON.parse(object.icon)
  end
end
