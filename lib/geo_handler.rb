# frozen_string_literal:true

require 'yaml'
require 'http'

# Define Handler
module GeoHandler
  # Model for Location_Info
  class Locater
    PLACE_TYPE = ['airport', 'cafe', 'city_hall', 'department_store',
                  'gas_station', 'hospital', 'library', 'police',
                  'local_government_office', 'restaurant', 'store',
                  'school', 'shopping_mall', 'subway_station',
                  'train_station', 'transit_station'].freeze

    attr_reader :url

    def initialize(url)
      @url = url
    end

    def all_sites
      selected_type.keys.reduce([]) do |sites_of_all_type, type|
        # sites_of_all_type.push(*sites_of_a_type(type, selected_type[type]))
        sites_of_a_type(type, selected_type[type], sites_of_all_type)
      end
    end

    # collect urls of wanted types
    def selected_type
      PLACE_TYPE.reduce({}) do |url_list, type|
        url_with_type = "#{url}&types=#{type}"
        url_list.update(type => url_with_type)
      end
    end

    # :reek:FeatureEnvy
    # :reek:TooManyStatements
    # retrieving geo info of each site based on a specific type
    def sites_of_a_type(type, url, site_list)
      get_geo_info(url)['results'].map do |site|
        site_info = {}
        site_info['location'] = site['geometry']['location']
        site_info['types'] = type
        site_info['name'] = site['name']
        site_info['address'] = site['vicinity']
        site_list << site_info
      end
      return site_list
    end

    # :reek:UtilityFunction
    def get_geo_info(url)
      HTTP.get(url).parse
    end
  end

  # Model for Network Object
  class HttpObject
    attr_reader :url

    def initialize(url)
      @url = url
    end

    # :reek:FeatureEnvy
    def status?
      http_response = HTTP.get(url).parse
      status = http_response['status']
      return 401 if status == 'REQUEST_DENIED'
      return 400 if status == 'INVALID_REQUEST'
      return 200 if status == 'OK'
    end
  end
end
