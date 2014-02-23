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
    def search_nearby(latitude, longitude) # and hack the URBN center into all responses
      # @client.explore_venues(:ll => "#{latitude},#{longitude}")
      @existing_places = Place.all(:select => :foursquare_venue_id).to_a
      @places_raw = @@foursq_client.search_venues(:ll => "#{latitude},#{longitude}", :limit => 15)
      @places = []

      @places << Place.find("4c80f8a62f1c236aac072b43") # hack the URBN center into all responses

      @places_raw.venues.each do |place|
        @places << ((Place.exists?(place.id) && Place.find(place.id)) ||
                    Place.new(foursquare_venue_id: place.id,
                              icon: place.categories.first.icon.to_json,
                              name: place.name,
                              distance: place.location.distance))
      end

      puts @places

      @places
    end

    def get_venue(venue_id)
      @venue_raw = @@foursq_client.venue(venue_id)
      puts @venue_raw.to_json

      @place = Place.new(foursquare_venue_id: @venue_raw.id,
                         icon: @venue_raw.categories.first.icon.to_json,
                         name: @venue_raw.name,
                         distance: @venue_raw.location.distance)
    end
  end
end
