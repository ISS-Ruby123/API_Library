# frozen_string_literal: false

module Mapper
    class AddMapper
        def initialize(token_source,name,address,comment)
            @token = Mapper::Token.new.fetch_token(token_source)
            @gateway = Gateways::SiteApi.new(@token)
            @name = name
            @addr = address
            @comment = comment
        end

        def DB_exists(name = @name , addr = @addr , comment = @comment)
            now_site = @gateway.geocode_of(addr)
            lat = now_site['lat']
            lng = now_site['lng']
            match_db = Site::Repository::Sites.exists_by_geocode(lat,lng)
            if match_db == false then Site::Repository::Sites.insert(name,addr,lat,lng) end
            Add(lat,lng,comment)
        end

        def Add(lat,lng,comment)
            site_id = Site::Repository::Sites.find_id_by_geocode(lat,lng)
            Comment::Repository::Comments.insert(site_id[0][:id],comment)
        end
    end
end