# frozen_string_literal: true

require_relative '../entities/site.rb'
require_relative '../../../infrastructure/database/orms/site_orm.rb'

module Repository
    #Repository for Site Entities
    class Sites
        def self.all
            Database::SiteOrm.all.map {|data| rebulid_entity(data)}
        end
        
        private
        
        def self.rebulid_entity(data)

            return nil unless data

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

        class PersistSite
            def initialize(entity)
                @entity = entity
            end

            def self.rebulid_entity(db_record)
                db_record.map do |data|
                    Sites.rebulid_entity(data)
                end
            end

            def create_site
                Database::SiteOrm.create(@entity.to_hash)
            end
        end
    end 
end