require 'foursquare2'

class Place #< ActiveResource::Base
  #self.site = "https://api.foursquare.com/v2/venues/search"
  #has_many :channels

#  attr_accessor :client
  @client = Foursquare2::Client.new(
    :client_id => ENV['FS_CLIENT_ID'],
    :client_secret => ENV['FS_CLIENT_SECRET'],
    :ssl => {
      :verify => OpenSSL::SSL::VERIFY_NONE#,
      #:ca_file => ENV['SSL_CERT_FILE']
      },
    :api_version => '20120505'
    )

  class << self
    def find_nearby(latitude, longitude)
      # @client.explore_venues(:ll => "#{latitude},#{longitude}")
      @places_raw = @client.search_venues(:ll => "#{latitude},#{longitude}", :limit => 15)
      @places = []

      @places_raw.venues.each do |place|
        @places << {
          icon: place.categories.first.icon,
          id: place.id,
          name: place.name,
          distance: place.location.distance,
          # channels: Place.self.channels
        }
      end

      @places
    end
  end
end
