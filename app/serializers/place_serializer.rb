class PlaceSerializer < ActiveModel::Serializer
  attributes :icon, :id, :name, :distance
  has_many :channels
end
