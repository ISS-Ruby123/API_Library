# frozen_string_literal: false

module Mapper
    class CommentMapper
        def initialize(token_source,address)
            @token = Mapper::Token.new.fetch_token(token_source)
            @gateway = Gateways::SiteApi.new(@token)
            @addr = address
        end

        def load_comment_from_db(addr = @addr)
            now_site = @gateway.geocode_of(addr)
            lat = now_site['lat']
            lng = now_site['lng']
            site_id = Site::Repository::Sites.find_id_by_geocode(lat,lng)
            comment = Comment::Repository::Comments.find_id_by_siteid(site_id)
            if !comment.empty? then comment[0][:feedback] end
        end

        def load_comment_from_API(lat,lng)
            site_id = Site::Repository::Sites.find_id_by_geocode(lat,lng)
            comment = Comment::Repository::Comments.find_id_by_siteid(site_id)
            if !comment.empty? then comment[0][:feedback] end
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