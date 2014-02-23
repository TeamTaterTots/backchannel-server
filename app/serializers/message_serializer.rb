class MessageSerializer < ActiveModel::Serializer
  attributes :id, :nick, :text, :ts

  def ts
    object.created_at
  end
end
