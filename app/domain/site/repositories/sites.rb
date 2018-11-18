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

      # Check existence of a site in sites table
      # param: lat: [float] latitude
      # param: lng: [float] longitude
      # return: true if record with fixed (lat, lng) exists, otherwise, false
      def self.exists_by_geocode(lat, lng)
        !Repository::Sites.find_id_by_geocode(lat, lng).empty?
      end

      # Find value of column 'id' by filtering column 'lat' & 'lng'
      # param: lat: [float] the latitude of the site
      # param: lng: [float] the longitude of the site
      # return: array of target records
      def self.find_id_by_geocode(lat, lng)
        Database::SiteOrm.where(lat: lat, lng: lng).all
      end

      # Insert a new record to the site table
      # param: name: [string] name of site
      # param: addr: [string] address of site
      # param: lat: [float] latitude of site
      # param: lng: [float] longitude of site
      def self.insert(name, address, lat, lng)
        db = Database::SiteOrm
        db.insert(name: name, address: address, lat: lat, lng: lng)
      end
    end
  end
end
