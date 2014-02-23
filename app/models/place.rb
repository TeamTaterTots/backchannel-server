require 'foursquare2'

class Place < ActiveRecord::Base
  self.primary_key = :foursquare_venue_id
  has_many :channels

  @@foursq_client = Foursquare2::Client.new(
    :client_id => ENV['FS_CLIENT_ID'],
    :client_secret => ENV['FS_CLIENT_SECRET'],
    :ssl => {
      :verify => OpenSSL::SSL::VERIFY_NONE#,
      #:ca_file => ENV['SSL_CERT_FILE']
      },
    :api_version => '20120505'
  )

  class << self
    def search_nearby(latitude, longitude)
      # @client.explore_venues(:ll => "#{latitude},#{longitude}")
      @existing_places = Place.all(:select => :foursquare_venue_id).to_a
      @places_raw = @@foursq_client.search_venues(:ll => "#{latitude},#{longitude}", :limit => 15)
      @places = []

      @places_raw.venues.each do |place|
        @places << ((Place.exists?(place.id) && Place.find(place.id)) ||
                    Place.new(icon: place.categories.first.icon,
                              foursquare_venue_id: place.id,
                              name: place.name,
                              distance: place.location.distance))
      end

      @places
    end
  end
end
