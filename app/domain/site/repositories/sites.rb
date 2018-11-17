# frozen_string_literal: true

require_relative '../entities/site.rb'
require_relative '../../../infrastructure/database/orms/site_orm.rb'
require_relative '../../../infrastructure/gateways/gateways.rb'

module Site
  module Repository
    # Repository for Site Entities
    class Sites
      # Find all records of the sites table
      # return: array of all records
      def self.all
        Database::SiteOrm.all
      end

      # Find value of column 'id' by filtering column 'address'
      # param: address: [string] the address of the site
      def self.find_id_by_address(address)
        lbs = Repository::Sites.find_geocode_by_address(address)
        Database::SiteOrm.where(lat: lbs[0], lng: lbs[1]).all
      end

      # Check existence of a site in sites table
      # param: lat: [float] latitude
      # param: lng: [float] longitude
      # return: true if record with fixed (lat, lng) exists, otherwise, false
      def self.exists_by_geocode(lat, lng)
        !Repository::Sites.find_id_by_geocde(lat, lng).nil?
      end

      # Find value of column 'id' by filtering column 'lat' & 'lng'
      # param: lat: [float] the latitude of the site
      # param: lng: [float] the longitude of the site
      # return: array of target records
      def self.find_id_by_geocode(lat, lng)
        Database::SiteOrm.where(lat: lat, lng: lng).all
      end

      # Find latitude and longitude by adrress
      # param: address: [string] address of site
      # return: [lat, lng]
      def self.find_geocode_by_address(address)
        location = geocode(address)
        [location['lat'], location['lng']]
      end

      # Insert a new record to the site table
      # param: name: [string] name of site
      # param: addr: [string] address of site
      def self.insert(name, address)
        lbs = Repository::Sites.find_geocode_by_address(address)
        Database::SiteOrm.insert(name: name, address: address, lat: lbs[0], lng: lbs[1])
      end
    end
  end
end
