# frozen_string_literal: false

module Mapper
  # class for AddMapper
  class AddMapper
    def initialize(token_source, name, address, rate, comment = nil)
      @token = Mapper::Token.new.fetch_token(token_source)
      @gateway = Gateways::SiteApi.new(@token)
      @name = name
      @addr = address
      @rate = rate
      @comment = comment
    end

    def DB_exists(name = @name, addr = @addr, rate = @rate, comment = @comment)
      now_site = @gateway.geocode_of(addr)
      lat = now_site['lat']
      lng = now_site['lng']
      match_db = Site::Repository::Sites.exists_by_geocode(lat, lng)
      if match_db == false then Site::Repository::Sites.insert(name, addr, lat, lng) end
      Add(lat, lng, rate, comment)
    end

    def Add(lat,lng, rate, comment = nil)
      site_id = Site::Repository::Sites.find_id_by_geocode(lat, lng)
      Rate::Repository::Rates.insert(site_id[0][:id], rate, comment)
    end
  end
end
