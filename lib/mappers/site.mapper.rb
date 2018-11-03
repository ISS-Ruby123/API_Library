# frozen_string_literal: false

require 'yaml'
require_relative '../gataways/lbs_api.rb'
require_relative '../entities/site.rb'

module LBS
  # Class SiteMapper
  class SiteMapper
    def initialize(token = LBS::GetToken.new.get_token , gateway_class = LBS::LbsApi)
      @token = token
      @gateway_class = gateway_class
      @gateway = @gateway_class.new(@token)
    end

    def load_near_site_list(lat, lng, distance)
      # @gateway.near_site_list(lat, lng, distance).map do |data|
      #     SiteMapper.build_entity(data)
      # end
      SiteMapper.build_entity(@gateway.near_site_list(lat, lng, distance))
    end

    def self.build_entity(data)
      DataMapper.new(data).build_entity
    end
  end

  # class DataMapper
  class DataMapper
    def initialize(data)
      @data = data
    end

    def build_entity
      puts @data.class
      Entity::Site.new(
        site: site
        # address: address,
        # location: location,
        # typeof: typeof,
        # name: name
      )
    end

    private

    def site
      @data
    end

    def address
      @data[3]
    end

    def location
      @data[0]
    end

    def typeof
      @data[1]
    end

    def name
      @data[2]
    end
  end

  # class GetToken
  class GetToken
    def token
      token = YAML.safe_load(File.read('../../config/secrets.yml'))
      token['Google_TOKEN']
    end
  end
end

x = LBS::SiteMapper.new
                   .load_near_site_list(24.793045, 120.993091, 500)

puts x.site
