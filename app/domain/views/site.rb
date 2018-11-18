# frozen_string_literal: true

require_relative '../../infrastructure/database/orms/site_orm.rb'

module Views
  # View for sites
  class Site
    def initialize(site)
      @site = site
    end

    def entity
      @site
    end

    # Search all near sites around specific (lat, lng)
    # return: [[lat_1, lng_1], [lat_2, lng_2], [lat_3, lng_3]]
    def search_site
      db = Site::Database::SiteOrm.all
      db_lat = db.reduce([]) { |box, record| box << record[:lat] }
      db_lng = db.reduce([]) { |box, record| box << record[:lng] }
      tmp = db_lat.zip(db_lng)
      result = @site.lat.zip(@site.lng)
      result << tmp
      result.uniq!
    end
  end
end
