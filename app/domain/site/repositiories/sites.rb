# frozen_string_literal: true

require_relative '../entities/site.rb'
require_relative '../../../infrastructure/database/orms/site_orm.rb'

module Repository
    #Repository for Site Entities
    class Sites
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