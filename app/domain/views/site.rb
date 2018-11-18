# frozen_string_literal: true

module Views
    # View for a single contributor
    class Sites
      def initialize(site)
        @site = site
      end
  
      def entity
        @site
      end
  
      def site_id
        @site[0][:id]
      end
  
      def site_name
        @site[0][:name]
      end

      def site_address
        @site[0][:address]
      end

      def site_lat
        @site[0][:lat]
      end

      def site_lng
        @site[0][:lng]
      end
    end
  end