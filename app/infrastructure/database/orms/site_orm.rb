# frozen_string_literal: true

require 'sequel'
require 'pg'

module Site
  module Database
    # Object-Relational Mapper for Members
    class SiteOrm < Sequel::Model(:sites)
      one_to_many :rate,
                  class: :'Site::Database::RateOrm',
                  key: :rate_id

      plugin :timestamps, update_on_create: true

      def self.find_or_create(site_info)
        first(name: site_info[:name]) || create(site_info)
      end
    end
  end
end
