# frozen_string_literal: true

require_relative '../entities/rate.rb'
require_relative '../../../infrastructure/database/orms/rate_orm.rb'

module Rate
  module Repository
    # Repository for Rate Entities
    class Rates
      # Insert a new record to the rates table
      # param: site_id: [integer] record index of site in site table
      # param: rate: [Integer] rate for the site
      # param: comment: [string] comment for the site
      def self.insert(site_id, rate, comment)
        Site::Database::RateOrm.insert(site_id: site_id, rate: rate, comment: comment)
      end

      # Find all records of the rates table
      # return: array of all records
      def self.all
        Site::Database::RateOrm.all
      end

      # Find value of column 'id' by filtering column 'site_id'
      # param: site_id: [integer] the record index of the site
      # return: array of target records
      def self.find_id_by_siteid(site_id)
        Site::Database::RateOrm.where(site_id: site_id).all
      end
    end
  end
end
