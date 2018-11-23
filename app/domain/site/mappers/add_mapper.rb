# frozen_string_literal: false

require 'yaml'
require_relative '../../../infrastructure/gateways/gateways.rb'

module Mapper
  # class AddMapper
  class AddMapper
    def initialize(token_source,name,address)
      @token = Mapper::Token.new.fetch_token(token_source)
      @gateway = Gateways::SiteApi.new(@token)
      @name = name
      @addr = address
    end

    def match(name = @name, addr = @addr)
      now_site = @gateway.geocode_of(addr)
      lat = now_site['lat']
      lng = now_site['lng']
      match_api = MatchAPIMapper.new(@token).match_near_site_list(now_site)
      match_db = Site::Repository::Sites.exists_by_geocode(lat,lng)
      if match_api == false && match_db == false then Site::Repository::Sites.insert(name,addr,lat,lng) else puts 'already have this site' end
    end

    # class MatchAPIMapper
    class MatchAPIMapper
      def initialize(token_source)
        @token = token_source
        @gateway = Gateways::SiteApi.new(@token)
      end

      def load_near_site_list(now_site)
        @gateway.near_site_list(now_site['lat'],now_site['lng'],50)
      end

      def match_near_site_list(now_site)
        site_list = load_near_site_list(now_site)
        match = 0

        site_list.map do |site|
          r_lat = (site['location']['lat'] - now_site['lat']).abs
          r_lng = (site['location']['lng'] - now_site['lng']).abs
          if  r_lat <= 0.00005 && r_lng <= 0.00005 then match+=1 end
        end

        if match == 1 then true else false end
      end
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