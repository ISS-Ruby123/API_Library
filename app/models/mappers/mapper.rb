# frozen_string_literal: false

require 'yaml'
require_relative '../../infrastructure/gateways/gateways.rb'
require_relative '../entities/entity.rb'

module Mapper
  # class SiteMapper
  class SiteMapper
    def initialize(token_source)
      @token = Mapper::Token.new.fetch_token(token_source)
      @gateway = Gateways::SiteApi.new(@token)
    end

    def load_near_site_list(lat, lng, distance)
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
      Entity::SiteEntity.new(
        sites: sites,
        address: address_of_sites,
        location: location_of_sites,
        latitude: latitude_of_sites,
        longitude: longitude_of_sites,
        type: type_of_sites,
        name: name_of_sites,
        name_addr: name_addr
      )
    end

    private

    def sites
      @data
    end

    def address_of_sites
      @data.reduce([]) do |addr_list, site|
        addr_list << site['address']
      end
    end

    def location_of_sites
      @data.reduce([]) do |location_list, site|
        location_list << site['location']
      end
    end

    def latitude_of_sites
      @data.reduce([]) do |lat_list, site|
        lat_list << site['location']['lat']
      end
    end

    def longitude_of_sites
      @data.reduce([]) do |lng_list, site|
        lng_list << site['location']['lng']
      end
    end

    def type_of_sites
      @data.reduce([]) do |type_list, site|
        type_list << site['types']
      end
    end

    def name_of_sites
      @data.reduce([]) do |name_list, site|
        name_list << site['name']
      end
    end

    def name_addr
      name_of_sites.zip(address_of_sites)
    end
  end

  # class GetToken
  class Token
    def fetch_token(yml_file)
      token = YAML.safe_load(File.read(yml_file))
      token['development']['Google_TOKEN']
    end
  end
end

# x = Mapper::SiteMapper.new('../../../config/secrets.yml')
#                       .load_near_site_list(24.793045, 120.993091, 500)

# puts x.name_addr
